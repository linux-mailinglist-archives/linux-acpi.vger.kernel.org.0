Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A65A51FD
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Aug 2022 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiH2Qir (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Aug 2022 12:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiH2Qiq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Aug 2022 12:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760F7199F
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661791124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WxRsE7EQMJiv6K2dZXGOVBXLJLl29rQ+5mWmxl/gbM=;
        b=Bw7LSWZmoJd9ukTN839EuUmbZ6I+G37ppXFjId9ux99LMffqPSfDfvWN6AMT4VwMGR3QVG
        Sg9qdKVqXjW7fEhFiqWhOuorsOGyoSK483mMDuGuqUpyZr4sLYGUCFKRepR0I/Qs2MHNkH
        QtIlAFX7my1cOgekh+Nle2s5D0bVNig=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-fYXd5ghaNESJUdFv7VHxMg-1; Mon, 29 Aug 2022 12:38:43 -0400
X-MC-Unique: fYXd5ghaNESJUdFv7VHxMg-1
Received: by mail-ed1-f72.google.com with SMTP id w17-20020a056402269100b0043da2189b71so5695164edd.6
        for <linux-acpi@vger.kernel.org>; Mon, 29 Aug 2022 09:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0WxRsE7EQMJiv6K2dZXGOVBXLJLl29rQ+5mWmxl/gbM=;
        b=c6Pfk6t9BHpa1cRip/n/4y0IwCb7+QIZvr2S5Zmoa6tAUvz3iWB1MOB6+TlWFLiWVx
         HlqWdK11+h3DMy9z6DskYpUf17HYQQYwpCGm4C6Ty2LmsH2E6XaD61iBwPcsdrgkuPdO
         wWa8nTSNLJ6SKD+zo/Aov0ncNARRn4HuxmcXkIAVVgyvaxLqGqYUl7IrloSGxRT86PO8
         FR0EkA8ydaHSscIThShraU/FNTZR/MuelP+DAcPftZAvq5LsIFJMaAkChcBvQ9wy2xiJ
         j8Dc/YiHeNeXnmbZ3QMJasgr1f6s/l+/oDfUiDtlSOQ4eAS08sWfHbtxm8M5R4rE4BE8
         U5eQ==
X-Gm-Message-State: ACgBeo183HGcI+lBUsbhKS0ksLc3Ebn131vgccsY5wu80hgrQKUaTfvL
        Ux/vtFbXEODKA9msvXRoiazhZtliVA0OR18i+3EHmerjKoVKzQrhVmDETW10kvmlmlZnjFrY8q8
        8bMBnK/YwAZcgGhHELWMbCg==
X-Received: by 2002:a17:906:794c:b0:73d:b881:e3fe with SMTP id l12-20020a170906794c00b0073db881e3femr13407211ejo.570.1661791122153;
        Mon, 29 Aug 2022 09:38:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7KDrwYc90teEfEl1Zc2ncVGkLhk0N5iPHyLsO/H/ER3QtEeICDKtEiVoJkDgSpOzs5xBP2eg==
X-Received: by 2002:a17:906:794c:b0:73d:b881:e3fe with SMTP id l12-20020a170906794c00b0073db881e3femr13407200ejo.570.1661791121902;
        Mon, 29 Aug 2022 09:38:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id y22-20020a1709060a9600b0073dc4385d3bsm4609035ejf.105.2022.08.29.09.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:38:41 -0700 (PDT)
Message-ID: <09d8b15d-d1a2-825d-fe1d-8b95eef499b1@redhat.com>
Date:   Mon, 29 Aug 2022 18:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] platform/x86: acer-wmi: Acer Aspire One AOD270/Packard
 Bell Dot keymap fixes
Content-Language: en-US
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Lee Chun-Yi <jlee@suse.com>
Cc:     linux-acpi@vger.kernel.org
References: <20220829163544.5288-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220829163544.5288-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/29/22 18:35, Hans de Goede wrote:
> 2 keymap fixes for the Acer Aspire One AOD270 and the same hardware
> rebranded as Packard Bell Dot SC:
> 
> 1. The F2 key is marked with a big '?' symbol on the Packard Bell Dot SC,
> this sends WMID_HOTKEY_EVENTs with a scancode of 0x27 add a mapping
> for this.
> 
> 2. Scancode 0x61 is KEY_SWITCHVIDEOMODE. Usually this is a duplicate
> input event with the "Video Bus" input device events. But on these devices
> the "Video Bus" does not send events for this key. Map 0x61 to KEY_UNKNOWN
> instead of using KE_IGNORE so that udev/hwdb can override it on these devs.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I've added this to my review-hans (soon to be for-next) branch now.

Regards,

Hans


> ---
>  drivers/platform/x86/acer-wmi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index b933a5165edb..9610742fe6aa 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -99,6 +99,7 @@ static const struct key_entry acer_wmi_keymap[] __initconst = {
>  	{KE_KEY, 0x22, {KEY_PROG2} },    /* Arcade */
>  	{KE_KEY, 0x23, {KEY_PROG3} },    /* P_Key */
>  	{KE_KEY, 0x24, {KEY_PROG4} },    /* Social networking_Key */
> +	{KE_KEY, 0x27, {KEY_HELP} },
>  	{KE_KEY, 0x29, {KEY_PROG3} },    /* P_Key for TM8372 */
>  	{KE_IGNORE, 0x41, {KEY_MUTE} },
>  	{KE_IGNORE, 0x42, {KEY_PREVIOUSSONG} },
> @@ -112,7 +113,13 @@ static const struct key_entry acer_wmi_keymap[] __initconst = {
>  	{KE_IGNORE, 0x48, {KEY_VOLUMEUP} },
>  	{KE_IGNORE, 0x49, {KEY_VOLUMEDOWN} },
>  	{KE_IGNORE, 0x4a, {KEY_VOLUMEDOWN} },
> -	{KE_IGNORE, 0x61, {KEY_SWITCHVIDEOMODE} },
> +	/*
> +	 * 0x61 is KEY_SWITCHVIDEOMODE. Usually this is a duplicate input event
> +	 * with the "Video Bus" input device events. But sometimes it is not
> +	 * a dup. Map it to KEY_UNKNOWN instead of using KE_IGNORE so that
> +	 * udev/hwdb can override it on systems where it is not a dup.
> +	 */
> +	{KE_KEY, 0x61, {KEY_UNKNOWN} },
>  	{KE_IGNORE, 0x62, {KEY_BRIGHTNESSUP} },
>  	{KE_IGNORE, 0x63, {KEY_BRIGHTNESSDOWN} },
>  	{KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} },	/* Display Switch */

