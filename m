Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB08E54F487
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jun 2022 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381379AbiFQJmT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jun 2022 05:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380925AbiFQJmS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jun 2022 05:42:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5041A69483
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jun 2022 02:42:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so5022372wra.9
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jun 2022 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NZv4CkZhHVjo2WiQVeulQzBHOA+fH2nS6TIJym/u7XA=;
        b=wLK3Z+5OFc/0E1XIc8LL/90johcd6W+wkAsVUSfrxaeVlkEj5UFZwBP2SaBBFcbiPe
         6QKWfAPioSFs0mHG+8JuRvpGfRDKCgIFzTUEVw9uHqHPYkGRH5KnW4y2uDattFW0Elew
         pzUUf42e2Io/lRgJ1ixs9Fylh9BnDtEZeF1JZhjq57BfG1ZyuMW5XrbOGaoob7/uJGCd
         3Yzn2c12Ct7hssXOTZAFvBv5HNuHC9b1euSSBEmjQkeIp2VJkY7+XJ5V1bWE0EzKPBfH
         BB3TcU1l/sKeEQAmOLDERw8nz1OLScdt7frEllsap+9Z0ZQ8zDC2l2VZ2wTuGDqEDREf
         /ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=NZv4CkZhHVjo2WiQVeulQzBHOA+fH2nS6TIJym/u7XA=;
        b=Et66O76/gNOT5NccfSMwPMLd6CZEtVGTQyHuF/vetztOhdwtbr36fHxrwUPd30yCi/
         FemTjQm/Xca6pVCH9dLfCAC2KZF4BEe4SD1igqw5RQq4MkkDWnmqDPleCYMDzZ7tx341
         OWO0nak8hv2BW5Qj2QUzrIzi5ipMx5QPbm/cAjHKeq9Yfa2vem/LuH5TyvYm6O6Zjqgn
         apVmfblsj8Rs2f+WUjDQCKHgBPFrhHnUdwacZHdRMQekDVhFo3JGdSoo7lj8DuKxiPA8
         HnkxJe32jKOqHBmwo5BRnjfi57pAlWAQtzFhzJKRygjTHxT4PqSyzd7E9PLNnhp8jnLl
         WEYA==
X-Gm-Message-State: AJIora/83PIABWmeGpik8G5nSvazlHbdYKnxYo3nNOXCfvzdDGJ3iDhw
        OjgIwPUw8VkO32NpnxtN9+fiZDN6hPzrqLOo
X-Google-Smtp-Source: AGRyM1t5CBxs8rFvCtjdn/6EoixNlpinrPqzTAfs/Ix5emh/N76GE+n4QqBBCNqRUjnO9yVIrSBzMQ==
X-Received: by 2002:a5d:4108:0:b0:213:b585:66c7 with SMTP id l8-20020a5d4108000000b00213b58566c7mr8373386wrp.335.1655458935880;
        Fri, 17 Jun 2022 02:42:15 -0700 (PDT)
Received: from localhost ([109.180.234.132])
        by smtp.gmail.com with ESMTPSA id m13-20020a5d4a0d000000b0021a2c923c72sm4213296wrq.69.2022.06.17.02.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 02:42:15 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Riwen Lu <luriwen@hotmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, rui.zhang@intel.com,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        punit.agrawal@bytedance.com, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v2] ACPI/processor: Remove unused function
 acpi_processor_get_limit_info()
References: <20220617025152.1908638-1-luriwen@hotmail.com>
        <TYWP286MB2601A75D517AE71EE569CE15B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 17 Jun 2022 10:42:14 +0100
In-Reply-To: <TYWP286MB2601A75D517AE71EE569CE15B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
        (Riwen Lu's message of "Fri, 17 Jun 2022 10:51:52 +0800")
Message-ID: <87v8szoccp.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Riwen Lu <luriwen@hotmail.com> writes:

> From: Riwen Lu <luriwen@kylinos.cn>
>
> Commit 22e7551eb6fd ("ACPI / processor: Remove acpi_processor_get_limit_info()"),
> left behind this, remove it.
>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>
> ---
> v1 -> v2:
>  - Make this patch base on ("ACPI: Split out processor thermal register
>    from ACPI PSS").

For such changes, it is better to send all the related patches as a
series so it's easy to see the dependencies . In a series the easy /
obvious fixes should be earlier so it's easier for them to be merged
while the more significant changes are still being discussed.

Hopefully in this case Rafael too agrees with the dependency patch -
otherwise, it's just extra churn on the lists.

But don't resend just yet - give some time for others to add their
feedback.

> ---
>  include/acpi/processor.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index ba1e3ed98d3d..9fa49686957a 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -441,7 +441,6 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
>  #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>  
>  /* in processor_thermal.c */
> -int acpi_processor_get_limit_info(struct acpi_processor *pr);
>  int acpi_processor_thermal_init(struct acpi_processor *pr,
>  				struct acpi_device *device);
>  void acpi_processor_thermal_exit(struct acpi_processor *pr,

Fwiw,

Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>
