Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF4599F9D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Aug 2022 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349868AbiHSPqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Aug 2022 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350255AbiHSPpn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Aug 2022 11:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB1102F11
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2022 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660923901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5fwWxYPKfIyLb1AtYH/Z3aEi33LuJRO9uvJrZeR5HOo=;
        b=XnpEgcdzXWJ0T0M5J41xHAiYq5A2pmiJ62sZWdk9ViNECwjtRHpX44XBa2VLU2B7Sq8bBa
        dYBX6dzOuHrVNIKAd9C15tyr5F7fXJQQLtuU9SKSjPaLWwWQ7UHUIQQraac4cWT5CLVSAg
        f9QEkRbyc19pZBlDtfcEHIXG13dFDBI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-Pxh3uSTGOUOlGklpCY_RZw-1; Fri, 19 Aug 2022 11:44:59 -0400
X-MC-Unique: Pxh3uSTGOUOlGklpCY_RZw-1
Received: by mail-qt1-f197.google.com with SMTP id d20-20020a05622a05d400b00344997f0537so2680824qtb.0
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2022 08:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5fwWxYPKfIyLb1AtYH/Z3aEi33LuJRO9uvJrZeR5HOo=;
        b=iqhy+vEdNtxBBq1ilZn2lkktZsdz7PUV3DPYXZRswdDENmX8XUD1dZq3XUej1cAR6w
         +4AHVTMM3m8KA+IN1uqhUH7a+Row5jEmR98DVIu+kjGhwBcH4AROAAzCcdA3jInQ1Y/1
         uwYbK5mF3/k9lIZejEZfMxwbtiPQRR06CDI5/0xsZY96y9U0HY8wRKNqHj63jRkOQql2
         Fh/VBmpxndfXglx2NYnhc435A/zU8FKtFmmVp/0sfMVmesuXLLFfYum9kKn+jJQSkm+8
         sZ5QUB0WbZOOYp1W/LYB91c/QNxoyfdvfxDezlHsDACTzhlF0n3St/CgMrhFTflVdEcg
         vKyA==
X-Gm-Message-State: ACgBeo2Wv3LuS0bm0GptVFWQaPxGl6yDb+YB47KqVB8Gs3RJCVRc1Xh/
        l2wqfAYs3l/4IZEQt7YCF4/5s0AsyJm9537+zAX5AK348l3I9KwyaDAuMJdT8tGHXfYbfV2uFy1
        NJ3snoulVtVoHzVfW1+ISQAVtJpycdCGvXf7lXQ==
X-Received: by 2002:a0c:b309:0:b0:496:6277:953e with SMTP id s9-20020a0cb309000000b004966277953emr6978211qve.77.1660923899233;
        Fri, 19 Aug 2022 08:44:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Hc2ZOCME0gpn+lc9a9OvgTyIXKsg/yLvVyJ8pQTmNOIEsbnWTS8GP9R4XmCi9QIDfpVs6VLTm+SlaDkSJT4M=
X-Received: by 2002:a0c:b309:0:b0:496:6277:953e with SMTP id
 s9-20020a0cb309000000b004966277953emr6978190qve.77.1660923899005; Fri, 19 Aug
 2022 08:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220819142519.5684-1-mario.limonciello@amd.com>
In-Reply-To: <20220819142519.5684-1-mario.limonciello@amd.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 19 Aug 2022 17:44:48 +0200
Message-ID: <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com>
Subject: Re: [RFC 0/2] Stop the abuse of Linux-* _OSI strings
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, Len Brown <lenb@kernel.org>,
        nouveau@lists.freedesktop.org, hdegoede@redhat.com,
        ddadap@nvidia.com, kai.heng.feng@canonical.com,
        Dell.Client.Kernel@dell.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 19, 2022 at 4:25 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> 3 _OSI strings were introduced in recent years that were intended
> to workaround very specific problems found on specific systems.
>
> The idea was supposed to be that these quirks were only used on
> those systems, but this proved to be a bad assumption.  I've found
> at least one system in the wild where the vendor using the _OSI
> string doesn't match the _OSI string and the neither does the use.
>
> So this brings a good time to review keeping those strings in the kernel.
> There are 3 strings that were introduced:
>
> Linux-Dell-Video
> -> Intended for systems with NVIDIA cards that didn't support RTD3
> Linux-Lenovo-NV-HDMI-Audio
> -> Intended for powering on NVIDIA HDMI device
> Linux-HPI-Hybrid-Graphics
> -> Intended for changing dGPU output
>
> AFAIK the first string is no longer relevant as nouveau now supports
> RTD3.  If that's wrong, this can be changed for the series.
>

Nouveau always supported RTD3, because that's mainly a kernel feature.
When those were introduced we simply had a bug only hit on a few
systems. And instead of helping us to debug this, this workaround was
added :( We were not even asked about this.

I am a bit curious about the other two though as I am not even sure
they are needed at all as we put other work arounds in place. @Lyude
Paul might know more about these.

