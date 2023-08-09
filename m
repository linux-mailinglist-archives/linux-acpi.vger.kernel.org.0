Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5FF7764EE
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjHIQXR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjHIQXQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 12:23:16 -0400
Received: from abi149hd126.arn1.oracleemaildelivery.com (abi149hd126.arn1.oracleemaildelivery.com [129.149.84.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3EEA
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=Gadn++4EjVVsRmhNsnho8v5YWfmpO7uppIE2cm0Fp+s=;
 b=S0bwxmLJXO2XLqqG33+seK+EMtU/sbof/DmvYiTNXP651AlaxdpzaOPXXFxkXaZHu+GIBkQY5IWm
   LUonAaD298r8pVSTmiu0cHzn01rsJ9ZA5K4MDefZJDIGkVpJahLjNH3CIEaIxPDkojAWVTd7NJiN
   lV1g6HJPxBMIbeoxY+vRC0t5BdiaehL5ATdrXuiPiS11mSM0eyGKdN6U1hAI1beDRqTTlpOrsHWh
   zpQ+oqvQXP3nI8s5kyIujcKNPofrLw2DGEzk5m+7m/MxDNfBCTEcdbZAiL6imsgb2N52zU3h7/yB
   xIHjKTgQy/u/GDoYqMqH7ia+EzPo6Z25wnDYRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=Gadn++4EjVVsRmhNsnho8v5YWfmpO7uppIE2cm0Fp+s=;
 b=feJsPMk1SMkLVi/GmYFECXMpu3hFe8WWbaMaC1Hr+CRxxT4/eiSRvzDEFRNI7kwO2ZtPMhL1VWfa
   tcuk2R4JXqLCiUtfk4+nFO6h4iGYuufYOeotbmryAnERw+9n0HveHhsvM1MBJXNtIjQ7yO9DCq5U
   lVq5/OXkBpUZqcrJEVELprJ5G1SQzFfIuzMfLNL5lt2MhahL5ETnL/hpen+S3ehwKOqc6BZ/hu7U
   Cb1CZLz9NJCeZ4w0ct7GMRyUx1uPuzY1u/EoBjOsPpP67ICEHXM3Q9oL1gCQEPxxcdTdEVUXWIXo
   XVJlT2DSM/nlRuIXMaXwpR3YGFZgZ/mx59VDUw==
Received: by omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230707 64bit (built Jul  7
 2023))
 with ESMTPS id <0RZ400GCITIOVNB0@omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-acpi@vger.kernel.org; Wed, 09 Aug 2023 16:23:12 +0000 (GMT)
Message-id: <07ab8e18-f07f-4115-94e1-9847f25dc8fe@augustwikerfors.se>
Date:   Wed, 9 Aug 2023 18:23:09 +0200
MIME-version: 1.0
Subject: Re: [PATCH v3 0/3] ACPI: resource: Fix regressions from
 "Remove "Zen" specific match and quirks"
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
References: <20230809085526.84913-1-hdegoede@redhat.com>
Content-language: en-US
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20230809085526.84913-1-hdegoede@redhat.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAFjkKLqxwgjRldpRepOR8tKy2qOwc29gDNrd3oI+91nVULdP4INmwym/2JVmni8
 O/P8l25u+m4ZoBvxqRTVEjvzaW6G/erLHmuPRxnRhHU2HwpIA9vPyq7ZJ5hr9wIO
 1PzGGIXflnNjD3nHNDx0CU87UPcsRBlrQmd/K87gwA7yEgxQa46qPlYU6zcSKh4x
 oS5Y1dXC5fFhAw1xRWE727eC0F5gsinx8HYERpsaq3rKy76C+vbWoOq/okzoSpg0
 9zX5I9BYSg2HPwTwXAmv/zO51ssX2yl8cjOKCmzqv5AxpleTir+HLZLVbZHif90c
 XiGJwCTEuHg2KIi2SYVV/i/QYzxpFKBQC6hXSIQg6dWcFFqpXhbBghGHHZ/4d27l
 Wy8/TEVks4LLgHfunBJ7D0qkDlVQtfINW+tk79vjgdrH3XMqevKjnosz//O3D0Ay y+f8I0M=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-08-09 10:55, Hans de Goede wrote:
> Hi All,
> 
> Here is v3 of my series to address the regressions wrt PS/2 IRQs
> not working on AMD zen models.
> 
> Changes in v3:
> - Add links to more bug reports caused by a9c4a912b7dc to the commitmsg
> - Also do the ZEN check for IRQ 12 (Reported-by August Wikerfors)
> - Move the gsi != 1 && gsi != 12 check to inside the #ifdef CONFIG_X86,
>    these being the i8042 IRQs is X86 specific and the "return true;" is
>    always done for #ifndef CONFIG_X86 already
> - Make acpi_int_src_ovr an array which keep track of the status
>    of all legacy IRQs and not just IRQ 1
> 
> Changes in v2:
> - Add 2 patches on top of the revert to avoid the revert causing
>    other models which are known to need the override to regress.
> 
> As discussed in the v1 thread:
> https://lore.kernel.org/linux-acpi/20230806151453.10690-1-hdegoede@redhat.com/
> 
> This series adds a few fixes on top of the revert to avoid the revert
> causing regressions on other AMD Zen systems where dropping the special
> Zen behavior was known to fix things.
> 
> As also mentioned in the thread this is intended as a short term fix
> for 6.4.y >= 6.4.7 and 6.5 to get all the systems which were working
> fine before commit a9c4a912b7dc ("ACPI: resource: Remove "Zen"
> specific match and quirks") to work again.
> 
> The long term plan is to see if we can read back what the BIOS
> has actually programmed as IRQ trigger-type / polarity into
> the IOAPIC.
> 
> Regards,
> 
> Hans
> 
> Hans de Goede (3):
>    ACPI: resource: revert "Remove "Zen" specific match and quirks"
>    ACPI: resource: Always use MADT override IRQ settings for all legacy
>      non i8042 IRQs
>    ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen
> 
>   arch/x86/include/asm/acpi.h |  2 ++
>   arch/x86/kernel/acpi/boot.c |  4 +++
>   drivers/acpi/resource.c     | 52 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 58 insertions(+)
> 

Thanks, I can confirm that this series fixes the regression caused by 
a9c4a912b7dc on Lenovo Yoga 7 14ARB7.

If relevant,
Tested-by: August Wikerfors <git@augustwikerfors.se>

Regards,
August Wikerfors
