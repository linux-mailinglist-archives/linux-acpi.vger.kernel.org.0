Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22AB431313
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 11:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJRJSa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 05:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231206AbhJRJS2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 05:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634548577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ng8kdqJ23aQK4vPsifW4Pte806k5USxiuKbYRKOPYw=;
        b=Rb6aXZ9HAy1uXruQ1tEnRanAs8chsAyy5meHbIexo2QOrPIdPm/lxsE4FmfhqFLogF/9Md
        csYCwHKVeoZLLyOEcN7ODx/+RCj2InWzgSA086BEvYEpw2j1SZbwasnFc0CCwT8jtm0np0
        j3Nuxs9w+we+UYitBHmscMvnXed+b9o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-LABzgg2nN_G70V8Nrz2J8w-1; Mon, 18 Oct 2021 05:16:12 -0400
X-MC-Unique: LABzgg2nN_G70V8Nrz2J8w-1
Received: by mail-ed1-f71.google.com with SMTP id l10-20020a056402230a00b003db6977b694so13725563eda.23
        for <linux-acpi@vger.kernel.org>; Mon, 18 Oct 2021 02:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=3ng8kdqJ23aQK4vPsifW4Pte806k5USxiuKbYRKOPYw=;
        b=vJJDbDGjC9xVR8TpnwOcay/yGJ6E4PSW3YgszUMJ1BWFWJ018qDYhQ29GC8fXvvSll
         jlKYCDXH9lSnmo0OYsBI35niuACpShBb8pkGDw68W7FccWNxOyt+wmTFX3+fd3Fr9QL+
         SG86Zz9HEiIzscBvKzeTTJ/QiYGRkkT1mZKrm87aU3UZcyT3WyGQ07N02Rc5ElpX8FXj
         24EA8NmYNXLLSUUkddyIJ3dOBxGIcNjl+G6jW9mmIBeeBlpnqmoxmn964tzQ+E1s/K+w
         bTh6gY21gy5E+VvglI+oCiDodnnxqaZ04RRb+6u+e2Rh+z7tPMBJPuvs5006p0PbobOP
         wSag==
X-Gm-Message-State: AOAM531/7gAWmeXYipfCVk0gpwlNAYYIEv85um3uKQXPYK51nXrz8c52
        qarP9DeWsSFDZcWnj6qAjJp8RYJkpLP/vzFtrW34jNZrHoX4NNcuIMn+KNzd/0XG2f0HsK9WmeZ
        lxATVEfT+q/m+DKO2Arf8dg==
X-Received: by 2002:a17:907:7d8b:: with SMTP id oz11mr27085444ejc.476.1634548570459;
        Mon, 18 Oct 2021 02:16:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh5ZSAiySnnprMuvel5RUKPpIObGbAeUv0uGxnwMU3vlM6/CquWzrbaJ+2hyp+LXQJFt+1tw==
X-Received: by 2002:a17:907:7d8b:: with SMTP id oz11mr27085428ejc.476.1634548570254;
        Mon, 18 Oct 2021 02:16:10 -0700 (PDT)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id y8sm8603072ejm.104.2021.10.18.02.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 02:16:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------VbaGbtKrdFXPX28iJEYW9CfG"
Message-ID: <3e6428f1-9411-fac6-9172-1dfe6de58c28@redhat.com>
Date:   Mon, 18 Oct 2021 11:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH 1/1] ACPI / PMIC: Add i2c address to intel_pmic_bytcrc
 driver
Content-Language: en-US
To:     Tsuchiya Yuto <kitakar@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211017161523.43801-1-kitakar@gmail.com>
 <20211017161523.43801-2-kitakar@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211017161523.43801-2-kitakar@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------VbaGbtKrdFXPX28iJEYW9CfG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/17/21 18:15, Tsuchiya Yuto wrote:
> On Microsoft Surface 3 (uses Intel's Atom Cherry Trail SoC), executing
> intel_soc_pmic_exec_mipi_pmic_seq_element() results in the following
> error message:
> 
>         [ 7196.356682] intel_soc_pmic_exec_mipi_pmic_seq_element: Not implemented
>         [ 7196.356686] intel_soc_pmic_exec_mipi_pmic_seq_element: i2c-addr: 0x6e reg-addr 0x57 value 0x63 mask 0xff
> 
> Surface 3 uses the PMIC device INT33FD, and the DSDT describes its _HRV
> value is 0x02 [1]:
> 
>         Scope (PCI0.I2C7)
>         {
>             Device (PMIC)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Name (_HID, "INT33FD" /* Intel Baytrail Power Management IC */)  // _HID: Hardware ID
>                 Name (_CID, "INT33FD" /* Intel Baytrail Power Management IC */)  // _CID: Compatible ID
>                 Name (_DDN, "CRYSTAL COVE+ AIC")  // _DDN: DOS Device Name
>                 Name (_HRV, 0x02)  // _HRV: Hardware Revision
>                 Name (_UID, One)  // _UID: Unique ID
>                 Name (_DEP, Package (0x01)  // _DEP: Dependencies
>                 {
>                     I2C7
>                 })
>         [...]
> 
> Due to this _HRV value, intel_pmic_bytcrc is used as the PMIC driver.
> However, the i2c address is currently not defined in this driver.
> This commit adds the missing i2c address 0x6e to the intel_pmic_bytcrc
> driver.
> 
> [1] https://github.com/linux-surface/acpidumps/blob/f8db3d150815aa21530635b7e646eee271e3b8fe/surface_3/dsdt.dsl#L10868
> 
> References: cc0594c4b0ef ("ACPI / PMIC: Add i2c address for thermal control")
> Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>

I believe that it is very unlikely that a device with a Cherry Trail SoC is actually using
the Bay Trail version of the PMIC, I would expect that to not necessarily work all that well.

So as Andy said, the right fix here is something like the:

+	hrv = 0x03;

Workaround from your cover-letter.

As Andy said we could use a DMI quirk for this, but chances are that the Microsoft Surface
DSDT is not the only one with the wrong HRV value. So instead it might be better to
just test for the SoC type as the attached patch does.

Tsuchiya, can you give the attached patch a try.

Andy, what do you think, should we go with the attached patch or would you prefer using
a DMI quirk ?

Regards,

Hans






> ---
>  drivers/acpi/pmic/intel_pmic_bytcrc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> index 2a692cc4b7ae..a64f50a42c54 100644
> --- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
> +++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> @@ -282,6 +282,7 @@ static struct intel_pmic_opregion_data intel_crc_pmic_opregion_data = {
>  	.power_table_count= ARRAY_SIZE(power_table),
>  	.thermal_table	= thermal_table,
>  	.thermal_table_count = ARRAY_SIZE(thermal_table),
> +	.pmic_i2c_address = 0x6e,
>  };
>  
>  static int intel_crc_pmic_opregion_probe(struct platform_device *pdev)
> 
--------------VbaGbtKrdFXPX28iJEYW9CfG
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-mfd-intel_soc_pmic-Use-CPU-id-check-instead-of-_HRV-.patch"
Content-Disposition: attachment;
 filename*0="0001-mfd-intel_soc_pmic-Use-CPU-id-check-instead-of-_HRV-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjNjU2YTAxYWQ4ZDkyNTJlYjU3NDdjM2YzYzFjODYxNTM0YWNiY2JkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBNb24sIDE4IE9jdCAyMDIxIDExOjExOjM0ICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gbWZkOiBpbnRlbF9zb2NfcG1pYzogVXNlIENQVS1pZCBjaGVjayBpbnN0ZWFkIG9m
IF9IUlYgY2hlY2sKIHRvIGRpZmZlcmVudGlhdGUgdmFyaWFudHMKClRoZSBJbnRlbCBDcnlz
dGFsIENvdmUgUE1JQyBoYXMgMiBkaWZmZXJlbnQgdmFyaWFudHMsIG9uZSBmb3IgdXNlIHdp
dGgKQmF5IFRyYWlsIChCWVQpIFNvQ3MgYW5kIG9uZSBmb3IgdXNlIHdpdGggQ2hlcnJ5IFRy
YWlsIChDSFQpIFNvQ3MuCgpTbyBmYXIgd2UgaGF2ZSBiZWVuIHVzaW5nIGFuIEFDUEkgX0hS
ViBjaGVjayB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4KdGhlIDIsIGJ1dCBhdCBsZWFzdCBv
biB0aGUgTWljcm9zb2Z0IFN1cmZhY2UgMywgd2hpY2ggaXMgYSBDSFQgZGV2aWNlLAp0aGUg
d3JvbmcgX0hSViB2YWx1ZSBpcyByZXBvcnRlZCBieSBBQ1BJLgoKU28gaW5zdGVhZCBzd2l0
Y2ggdG8gYSBDUFUtSUQgY2hlY2sgd2hpY2ggYXZvaWRzIHVzIHJlbHlpbmcgb24gdGhlCnBv
c3NpYmx5IHdyb25nIEFDUEkgX0hSViB2YWx1ZS4KClJlcG9ydGVkLWJ5OiBUc3VjaGl5YSBZ
dXRvIDxraXRha2FyQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL21mZC9LY29uZmlnICAgICAgICAg
ICAgICAgfCAgMiArLQogZHJpdmVycy9tZmQvaW50ZWxfc29jX3BtaWNfY29yZS5jIHwgMzUg
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21m
ZC9LY29uZmlnIGIvZHJpdmVycy9tZmQvS2NvbmZpZwppbmRleCBjYTBlZGFiOTFhZWIuLjU4
ODY2YzQyNTQ5NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZmQvS2NvbmZpZworKysgYi9kcml2
ZXJzL21mZC9LY29uZmlnCkBAIC01ODcsNyArNTg3LDcgQEAgY29uZmlnIExQQ19TQ0gKIGNv
bmZpZyBJTlRFTF9TT0NfUE1JQwogCWJvb2wgIlN1cHBvcnQgZm9yIENyeXN0YWwgQ292ZSBQ
TUlDIgogCWRlcGVuZHMgb24gQUNQSSAmJiBIQVNfSU9NRU0gJiYgSTJDPXkgJiYgR1BJT0xJ
QiAmJiBDT01NT05fQ0xLCi0JZGVwZW5kcyBvbiBYODYgfHwgQ09NUElMRV9URVNUCisJZGVw
ZW5kcyBvbiBYODYKIAlkZXBlbmRzIG9uIEkyQ19ERVNJR05XQVJFX1BMQVRGT1JNPXkKIAlz
ZWxlY3QgTUZEX0NPUkUKIAlzZWxlY3QgUkVHTUFQX0kyQwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tZmQvaW50ZWxfc29jX3BtaWNfY29yZS5jIGIvZHJpdmVycy9tZmQvaW50ZWxfc29jX3Bt
aWNfY29yZS5jCmluZGV4IGRkZDY0ZjllMzM0MS4uOWUxNTg4ZDRjODJlIDEwMDY0NAotLS0g
YS9kcml2ZXJzL21mZC9pbnRlbF9zb2NfcG1pY19jb3JlLmMKKysrIGIvZHJpdmVycy9tZmQv
aW50ZWxfc29jX3BtaWNfY29yZS5jCkBAIC0xNyw0OCArMTcsMzMgQEAKICNpbmNsdWRlIDxs
aW51eC9wd20uaD4KICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4KIAotI2luY2x1ZGUgImlu
dGVsX3NvY19wbWljX2NvcmUuaCIKKyNpbmNsdWRlIDxhc20vY3B1X2RldmljZV9pZC5oPgor
I2luY2x1ZGUgPGFzbS9pbnRlbC1mYW1pbHkuaD4KIAotLyogQ3J5c3RhbCBDb3ZlIFBNSUMg
c2hhcmVzIHNhbWUgQUNQSSBJRCBiZXR3ZWVuIGRpZmZlcmVudCBwbGF0Zm9ybXMgKi8KLSNk
ZWZpbmUgQllUX0NSQ19IUlYJCTIKLSNkZWZpbmUgQ0hUX0NSQ19IUlYJCTMKKyNpbmNsdWRl
ICJpbnRlbF9zb2NfcG1pY19jb3JlLmgiCiAKIC8qIFBXTSBjb25zdW1lZCBieSB0aGUgSW50
ZWwgR0ZYICovCiBzdGF0aWMgc3RydWN0IHB3bV9sb29rdXAgY3JjX3B3bV9sb29rdXBbXSA9
IHsKIAlQV01fTE9PS1VQKCJjcnlzdGFsX2NvdmVfcHdtIiwgMCwgIjAwMDA6MDA6MDIuMCIs
ICJwd21fcG1pY19iYWNrbGlnaHQiLCAwLCBQV01fUE9MQVJJVFlfTk9STUFMKSwKIH07CiAK
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgeDg2X2NwdV9pZCBieXRfY3B1X2lkc1tdID0geworCVg4
Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFUT01fU0lMVkVSTU9OVCwgTlVMTCksCisJe30K
K307CisKIHN0YXRpYyBpbnQgaW50ZWxfc29jX3BtaWNfaTJjX3Byb2JlKHN0cnVjdCBpMmNf
Y2xpZW50ICppMmMsCiAJCQkJICAgIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkICppMmNf
aWQpCiB7CiAJc3RydWN0IGRldmljZSAqZGV2ID0gJmkyYy0+ZGV2OwogCXN0cnVjdCBpbnRl
bF9zb2NfcG1pY19jb25maWcgKmNvbmZpZzsKIAlzdHJ1Y3QgaW50ZWxfc29jX3BtaWMgKnBt
aWM7Ci0JdW5zaWduZWQgbG9uZyBsb25nIGhydjsKLQlhY3BpX3N0YXR1cyBzdGF0dXM7CiAJ
aW50IHJldDsKIAotCS8qCi0JICogVGhlcmUgYXJlIDIgZGlmZmVyZW50IENyeXN0YWwgQ292
ZSBQTUlDcyBhIEJheSBUcmFpbCBhbmQgQ2hlcnJ5Ci0JICogVHJhaWwgdmVyc2lvbiwgdXNl
IF9IUlYgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZSAyLgotCSAqLwotCXN0YXR1cyA9
IGFjcGlfZXZhbHVhdGVfaW50ZWdlcihBQ1BJX0hBTkRMRShkZXYpLCAiX0hSViIsIE5VTEws
ICZocnYpOwotCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgewotCQlkZXZfZXJyKGRldiwg
IkZhaWxlZCB0byBnZXQgUE1JQyBoYXJkd2FyZSByZXZpc2lvblxuIik7Ci0JCXJldHVybiAt
RU5PREVWOwotCX0KLQotCXN3aXRjaCAoaHJ2KSB7Ci0JY2FzZSBCWVRfQ1JDX0hSVjoKKwlp
ZiAoeDg2X21hdGNoX2NwdShieXRfY3B1X2lkcykpCiAJCWNvbmZpZyA9ICZpbnRlbF9zb2Nf
cG1pY19jb25maWdfYnl0X2NyYzsKLQkJYnJlYWs7Ci0JY2FzZSBDSFRfQ1JDX0hSVjoKKwll
bHNlCiAJCWNvbmZpZyA9ICZpbnRlbF9zb2NfcG1pY19jb25maWdfY2h0X2NyYzsKLQkJYnJl
YWs7Ci0JZGVmYXVsdDoKLQkJZGV2X3dhcm4oZGV2LCAiVW5rbm93biBoYXJkd2FyZSByZXYg
JWxsdSwgYXNzdW1pbmcgQllUXG4iLCBocnYpOwotCQljb25maWcgPSAmaW50ZWxfc29jX3Bt
aWNfY29uZmlnX2J5dF9jcmM7Ci0JfQogCiAJcG1pYyA9IGRldm1fa3phbGxvYyhkZXYsIHNp
emVvZigqcG1pYyksIEdGUF9LRVJORUwpOwogCWlmICghcG1pYykKLS0gCjIuMzEuMQoK
--------------VbaGbtKrdFXPX28iJEYW9CfG--

