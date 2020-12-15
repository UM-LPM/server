<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"/>

    <xsl:template match="domain">
        <domain type='kvm'>
            <xsl:copy-of select="name"/>
            <xsl:copy-of select="vcpu"/>
            <xsl:copy-of select="cpu"/>
            <xsl:copy-of select="memory"/>
            <os>
                <type arch="x86_64">hvm</type>
            </os>
            <features>
                <acpi/>
            </features>
            <devices>
                <xsl:for-each select=".">
                    <xsl:apply-templates select="disk"/>
                    <xsl:apply-templates select="network-interface"/>
                    <xsl:apply-templates select="direct-interface"/>
					<xsl:apply-templates select="spice"/>
                </xsl:for-each>
                <console type="pty"/>
                <rng model='virtio'>
                    <backend model='random'>/dev/urandom</backend>
                </rng>
            </devices>
        </domain>
    </xsl:template>

    <xsl:template match="disk">
        <disk type='volume' device='disk'>
            <driver name='qemu' type='qcow2'/>
            <source>
                <xsl:attribute name='pool'>
                    <xsl:value-of select='@pool'/>
                </xsl:attribute>
                <xsl:attribute name='volume'>
                    <xsl:value-of select='@volume'/>
                </xsl:attribute>
            </source>
            <target dev='vda' bus='virtio'/>
        </disk>
    </xsl:template>

    <xsl:template match='network-interface'>
        <interface type='network'>
            <source>
                <xsl:attribute name='network'>
                    <xsl:value-of select='@network'/>
                </xsl:attribute>
            </source>
            <mac>
                <xsl:attribute name='address'>
                    <xsl:value-of select='@mac'/>
                </xsl:attribute>
            </mac>
            <model type='virtio'/>
        </interface>
    </xsl:template>

    <xsl:template match='direct-interface'>
        <interface type="direct">
            <!--<xsl:attribute name='type'>
                <xsl:value-of select='@type'/>
            </xsl:attribute>-->
            <source>
                <xsl:attribute name='dev'>
                    <xsl:value-of select='@dev'/>
                </xsl:attribute>
            </source>
            <model type='virtio'/>
        </interface>
    </xsl:template>
	
	<xsl:template match='spice'>
		<graphics type='spice'/>
		<video>
			<model type='qxl' />
		</video>
	</xsl:template>
</xsl:stylesheet>
