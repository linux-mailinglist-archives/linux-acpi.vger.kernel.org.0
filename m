Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A526632A4
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jan 2023 22:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjAIVTH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Jan 2023 16:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbjAIVR6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2023 16:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F6912099
        for <linux-acpi@vger.kernel.org>; Mon,  9 Jan 2023 13:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673298893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFZjjWis11GFBdGRfw4ckgxzH8gAgz/JcfmlSBC9SCo=;
        b=RlnsdOaSpWqQOd0+ien1GYMHuWN5sjh76bxM8hAl6KfxtXH1N+pJsSSziehbeOzzT3A7+L
        2McpYTtD8/XefAVegVfzbCgImtXD/SBnRXpQeA51oZx2xiWkdd/Mt9wu2BP7kG4ISq1GGm
        fx2inNhgmslEwjGygj5LVDPLM/JSSV4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-ur_TzXivPHqF2HJ2GE9GqA-1; Mon, 09 Jan 2023 16:14:52 -0500
X-MC-Unique: ur_TzXivPHqF2HJ2GE9GqA-1
Received: by mail-ej1-f72.google.com with SMTP id ga21-20020a1709070c1500b007c171be7cd7so6331623ejc.20
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2023 13:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFZjjWis11GFBdGRfw4ckgxzH8gAgz/JcfmlSBC9SCo=;
        b=0u8Wjk+A0149I0muTnuS5kfegnEyvTXA1aQDOHe3H5XMB5KnGaSrZ/7jkSF+Xnt+b6
         TuP5kljS75pXNedCYkEqtS9vnBMJFaqEGjifkdeOMvsoKwsYyMffFyeIE988SniMDM8M
         F7GIJO+nZngs0njYDuvzhL8/KLZ+NZKRmOObK0DCeSbCi3OgfD3R+Om7QxStBlXRgeZ8
         0EUKxZxcrZ832vsbP0w33ul0W/RH10mD8TFgutQpsLgmfQaOjsACrJCihlYxS5P+73ZA
         k9xRCkBKjA+lysJX+rOB/D/7NCpaRkYVHmrvEL8WGa4jzU+hL8Hucanul8AGf3FibdOh
         41xw==
X-Gm-Message-State: AFqh2kpm3KZLwORySvKetsbvkRlYrwSvzT0k0LD0sjFSlrAM4IxiAocA
        HUsgqZs/6z+3p3tMPXhDpQ0Y7YQM3VK1zqyINi4c+q0neCCdN9vhxl+UM/ixKXfiLaRbC2xPicD
        5kfK4cBTrGlIsN3a9Q8clFQ==
X-Received: by 2002:a17:906:37c8:b0:84d:2fce:f325 with SMTP id o8-20020a17090637c800b0084d2fcef325mr8187001ejc.49.1673298891139;
        Mon, 09 Jan 2023 13:14:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXty9f/SOo1KeDaQ7gnEOkCuJZFKZ116mudq5XcNBYeVBMcWowj083/EOk0IPXOacF+AvlCeVQ==
X-Received: by 2002:a17:906:37c8:b0:84d:2fce:f325 with SMTP id o8-20020a17090637c800b0084d2fcef325mr8186987ejc.49.1673298890907;
        Mon, 09 Jan 2023 13:14:50 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id la16-20020a170907781000b0084d494b24dcsm1519339ejc.161.2023.01.09.13.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:14:50 -0800 (PST)
Message-ID: <1385de27-1a13-b36f-b255-4e6b016453d7@redhat.com>
Date:   Mon, 9 Jan 2023 22:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] ACPI: Fix selecting the wrong ACPI fwnode for the iGPU on
 some Dell laptops
Content-Language: en-US, nl
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20230109205721.60694-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230109205721.60694-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

p.s.

This fixes a regression in 6.1, adding the regressions list to the Cc.

Once we figure out the best way to fix this (this patch is more of a proposal
how to fix this rather then a definitive fix), we should also backport
the fix to 6.1.y.


On 1/9/23 21:57, Hans de Goede wrote:
> The Dell Latitude E6430 both with and without the optional NVidia dGPU
> has a bug in its ACPI tables which is causing Linux to assign the wrong
> ACPI fwnode / companion to the pci_device for the i915 iGPU.
> 
> Specifically under the PCI root bridge there are these 2 ACPI Device()s :
> 
>  Scope (_SB.PCI0)
>  {
>      Device (GFX0)
>      {
>          Name (_ADR, 0x00020000)  // _ADR: Address
>      }
> 
>      ...
> 
>      Device (VID)
>      {
>          Name (_ADR, 0x00020000)  // _ADR: Address
>          ...
> 
>          Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
>          {
>              VDP8 = Arg0
>              VDP1 (One, VDP8)
>          }
> 
>          Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
>          {
>              ...
>          }
>          ...
>      }
>  }
> 
> The non-functional GFX0 ACPI device is a problem, because this gets
> returned as ACPI companion-device by acpi_find_child_device() for the iGPU.
> 
> This is a long standing problem and the i915 driver does use the ACPI
> companion for some things, but works fine without it.
> 
> However since commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> acpi_get_pci_dev() relies on the physical-node pointer in the acpi_device
> and that is set on the wrong acpi_device because of the wrong
> acpi_find_child_device() return. This breaks the ACPI video code, leading
> to non working backlight control in some cases.
> 
> Make find_child_checks() return a higher score for children which have
> pnp-ids set by various scan helpers like acpi_is_video_device(), so
> that it picks the right companion-device.
> 
> An alternative approach would be to directly call acpi_is_video_device()
> from find_child_checks() but that would be somewhat computationally
> expensive given that acpi_find_child_device() iterates over all the
> PCI0 children every time it is called.
> 
> Fixes: 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/glue.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index 204fe94c7e45..2055dfd7678b 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -75,7 +75,7 @@ static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
>  }
>  
>  #define FIND_CHILD_MIN_SCORE	1
> -#define FIND_CHILD_MAX_SCORE	2
> +#define FIND_CHILD_MAX_SCORE	3
>  
>  static int match_any(struct acpi_device *adev, void *not_used)
>  {
> @@ -89,15 +89,25 @@ static bool acpi_dev_has_children(struct acpi_device *adev)
>  
>  static int find_child_checks(struct acpi_device *adev, bool check_children)
>  {
> +	int score = FIND_CHILD_MIN_SCORE;
>  	unsigned long long sta;
>  	acpi_status status;
>  
>  	if (check_children && !acpi_dev_has_children(adev))
>  		return -ENODEV;
>  
> +	/*
> +	 * For devices without a _STA method, prefer devices without a _HID
> +	 * (which conflicts with having an _ADR) but which have been matched
> +	 * in some other way, like e.g. by acpi_is_video_device() over devices
> +	 * with no ids at all.
> +	 */
> +	if (!adev->pnp.type.platform_id && adev->pnp.type.hardware_id)
> +		score++;
> +
>  	status = acpi_evaluate_integer(adev->handle, "_STA", NULL, &sta);
>  	if (status == AE_NOT_FOUND)
> -		return FIND_CHILD_MIN_SCORE;
> +		return score;
>  
>  	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_ENABLED))
>  		return -ENODEV;

