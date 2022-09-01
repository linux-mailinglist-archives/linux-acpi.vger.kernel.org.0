Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7522E5A89D7
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Sep 2022 02:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiIAAeW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Aug 2022 20:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIAAeV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2022 20:34:21 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCD1144C4
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 17:34:20 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E89512C08A2;
        Thu,  1 Sep 2022 00:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1661992455;
        bh=j6R+E8f7n9PWFzUOnN8FdSqKrBDFsM1qjZzctBSS9gI=;
        h=From:To:Subject:Date:From;
        b=1mF9IJMBPu/Gg+3PJF5rem1QhiFgabEh5yq4gIUoRHzD6OWStuQaE/oHilbnK96YE
         OkJ2dNNBEL7y6GfUeG6uMzHcItChWElgZXVHzjXAtafJLjAmPBRY2ZLl00xoEjnlLw
         dSohstnR4T94LoUYYku1rvMr5l4r/1PmEyKjH9riTv/UFN1s+DSc4Dwgm3fyQbl6aq
         vPHBnLNRqa4QnPN4HoEP0t2x5nma6SmwsNnyI9P896tWtxItHLyX8+x2nCRoCUI3Ap
         PovFmVSOuziiUBy10UqJLt7fdOu8blXjnXff9rs+M+N9XDkpqe8AtKt3ig6HqPuvzM
         tQe+ulplbTkNw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B630ffe070000>; Thu, 01 Sep 2022 12:34:15 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.38; Thu, 1 Sep 2022 12:34:15 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.040; Thu, 1 Sep 2022 12:34:15 +1200
From:   Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Using phandles in an ACPI SSDT overlay, is it possible?
Thread-Topic: Using phandles in an ACPI SSDT overlay, is it possible?
Thread-Index: AQHYvZqQJ+nd5PSCBUOYd+pMaC4Z3w==
Date:   Thu, 1 Sep 2022 00:34:15 +0000
Message-ID: <c9394d7d77a24a19ba9c8bf66b216002@svr-chch-ex1.atlnz.lc>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eJVtc0h1 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=8nJEP1OIZ-IA:10 a=xOM3xZuef0cA:10 a=6MUlve7IY2HwULxJn4cA:9 a=wPNLvfGTeEIA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,=0A=
=0A=
I am looking at using the special PRP0001 device ID to use a device-tree dr=
iver from an ACPI overlay.=0A=
=0A=
Reading through the documentation, I've found how to pass most of the devic=
e-tree properties we need (gpio pins, integers, etc).=0A=
One thing that I've not been able to find however, is a mechanism equivalen=
t to device-tree's phandles.=0A=
=0A=
For our driver, we want to pass an i2c bus, (the bus itself, not just one a=
ddress on the bus)=0A=
To do this with device-tree, we have been using the following:=0A=
=0A=
&my_mux { /* I2C MUX */=0A=
	my_mux_channel: i2c@0 {=0A=
		#address-cells =3D <1>;=0A=
		#size-cells =3D <0>;=0A=
		reg =3D <0>;=0A=
	};=0A=
};=0A=
=0A=
/ {=0A=
	sfpcage@1 {=0A=
		compatible =3D "atl,sfpcage";        =0A=
		...=0A=
		i2c-bus =3D <&my_mux_channel>;    /* this is what I'm unsure about doing =
in ACPI */=0A=
};=0A=
=0A=
In our driver, we access the bus using:=0A=
    nadapter =3D of_parse_phandle(node, "i2c-bus", 0);=0A=
    ...=0A=
    adapter =3D of_find_i2c_adapter_by_node(nadapter);=0A=
=0A=
=0A=
My question is:=0A=
=0A=
Is this possible to do this when using ACPI with its device-tree compatibil=
ity layer (PRP0001 and the daffd814-6eba-4d8c-8a91-bc9bbf4aa301 _DSD)?=0A=
Or are we going to need to change our driver to use a different mechanism t=
o reference the i2c bus?=0A=
=0A=
We are using kernel version 5.15.x. I have also included my work-in-progres=
s ACPI source code below. =0A=
=0A=
=0A=
Thank you for your time,=0A=
Joshua Scott=0A=
=0A=
=0A=
DefinitionBlock ("mux_and_sfp.aml", "SSDT", 1, "ATL", "TEST", 0x00000001)=
=0A=
{=0A=
    External (\_SB.I2CA, DeviceObj)=0A=
=0A=
    Scope (\_SB.I2CA)=0A=
    {=0A=
        // 8-Channel i2c mux=0A=
        Device (MUX0)=0A=
        {=0A=
            Name (_HID, "PRP0001")=0A=
            Name (_CRS, ResourceTemplate () {=0A=
                I2cSerialBusV2 (0x74, ControllerInitiated,=0A=
                                400000, AddressingMode7Bit,=0A=
                                "\\_SB.I2CA", 0x00,=0A=
                                ResourceConsumer, , Exclusive, )=0A=
            })=0A=
            Name (_DSD, Package () {=0A=
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"), // Device =
Properties UUID=0A=
                Package () {=0A=
                    Package () { "compatible", "nxp,pca9548" },=0A=
                    Package () { "i2c-mux-idle-disconnect", "" },=0A=
                }=0A=
            })=0A=
=0A=
            // Unused channels=0A=
            Device (CH00) { Name (_ADR, 0) }=0A=
            Device (CH01) { Name (_ADR, 1) }=0A=
            Device (CH02) { Name (_ADR, 2) }=0A=
            Device (CH03) { Name (_ADR, 3) }=0A=
            Device (CH04) { Name (_ADR, 4) }=0A=
            Device (CH05) { Name (_ADR, 5) }=0A=
            Device (CH06) { Name (_ADR, 6) }=0A=
=0A=
            // Channel 7 contains GPIO expander.=0A=
            Device (CH07)=0A=
            {=0A=
                Name (_ADR, 7)=0A=
=0A=
                Device (GPIO)=0A=
                {=0A=
                    Name (_HID, "PRP0001")=0A=
                    Name (_CRS, ResourceTemplate () {=0A=
                        I2cSerialBusV2 (0x25, ControllerInitiated,=0A=
                                        400000, AddressingMode7Bit,=0A=
                                        "^^CH07", 0x00,=0A=
                                        ResourceConsumer, , Exclusive, )=0A=
                    })=0A=
                    Name (_DSD, Package () {=0A=
                        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"), //=
 Device Properties UUID=0A=
                        Package () {=0A=
                            Package () { "compatible", "nxp,pca9555" },=0A=
                        }=0A=
                    })=0A=
                }=0A=
            }=0A=
        }=0A=
=0A=
        Device (SFP1)=0A=
        {=0A=
            Name (_HID, "PRP0001")=0A=
            Name (_CRS, ResourceTemplate ()=0A=
                {=0A=
                    // detect-gpio=0A=
                    GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly=
,  "\\_SB.I2CA.MUX0.CH07.GPIO", 0, ResourceConsumer) { 2 }=0A=
                    // rxlos-gpio=0A=
                    GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly=
,  "\\_SB.I2CA.MUX0.CH07.GPIO", 0, ResourceConsumer) { 0 }=0A=
                    //txdis-gpio=0A=
                    GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnl=
y, "\\_SB.I2CA.MUX0.CH07.GPIO", 0, ResourceConsumer) { 15 }=0A=
                    // i2c-bus, unsure if I2cSerialBusV2 is what we want to=
 use here=0A=
                    I2cSerialBusV2 (???, ControllerInitiated, 400000, Addre=
ssingMode7Bit, "\\_SB.I2CA.MUX0.CH01", 0x00, ResourceConsumer, , Exclusive,=
 )=0A=
                })=0A=
=0A=
            Name (_DSD, Package () {=0A=
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"), // Device =
Properties UUID=0A=
                Package () {=0A=
                    Package () { "compatible", "atl,sfpcage" },=0A=
                    Package () { "board_index", 0 },=0A=
                    Package () { "label", "0.1" },=0A=
                    Package () { "port", "1" },=0A=
                    Package () { "detect-gpio", Package () {^SFP1, 0, 0, 1}=
}, // Device reference, index into _CRS, pin within GpioIo resource, active=
_low.=0A=
                    Package () { "rxlos-gpio", Package () {^SFP1, 1, 0, 0}}=
,=0A=
                    Package () { "txdis-gpio", Package () {^SFP1, 2, 0, 0}}=
,=0A=
                    Package () { "i2c-bus", ??? } // Unsure how to pass a d=
evie-tree style phandle.=0A=
                }=0A=
            })=0A=
=0A=
        }=0A=
    }=0A=
}=
