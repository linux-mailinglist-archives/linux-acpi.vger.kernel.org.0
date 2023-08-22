Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E81783864
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Aug 2023 05:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjHVDQL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Aug 2023 23:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjHVDQL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2023 23:16:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3C918B
        for <linux-acpi@vger.kernel.org>; Mon, 21 Aug 2023 20:16:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b9cd6876bbso1073127a34.1
        for <linux-acpi@vger.kernel.org>; Mon, 21 Aug 2023 20:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1692674168; x=1693278968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6rnVFDEA1BgBA+mUdzjBw9TA8+0/ZjVyvpi44MeCEbk=;
        b=D+i+k3YVcHfIwdFKTK6u+UcarnqVXwgBhW3iKfiT2Zwn1ub4l+WbMH1beEW9Mpqi0Y
         Dtdn/bmO42xhBa7dak0KWbyRJF9QTIc0utQQrOl7sQmHB+ZUoM0OGHssl2GjfXakNqZW
         tDH0zv4298Nk8X8PbVeidqoc7Clz9/Fc2+4dexHUmatT7pRUuRtkqirGnYgzAIx49/Ao
         OpRmVcgize74ORrRKgLFPTwRTfWmKwHmcHVYq9GDPfW++IM3bdRWk0cZRsK4HTyKdKS4
         /gix+jRBJJzXCGW3z5eZGWBUgIFVvFXCZks59GOGGzoKZAHPw0JrS+lzolt4DDoCeNFO
         Oa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692674168; x=1693278968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rnVFDEA1BgBA+mUdzjBw9TA8+0/ZjVyvpi44MeCEbk=;
        b=DK0GzM6vEdCnULQVARGz7UlI03wUvdbcG+p0rI7QW+RbRuzEOHVqtkL9Z8gbU6j7Za
         ozuWcYx5D+1Zd/k10beWJRO9AkuWi2YDSnUAkBYcowlDA1GcuSveDO/JUQHFv3O17WYm
         2AFK09t6Lh6Jt8BvJ5XsOPr7hLDUsrBi0nEPvhRkZhBSoFoSKycjoDhia9HbYpQYtzij
         c3TNz552HE5M7YOX3ZfHCpOb9A0nMdHhgHgQeuyi2DTuzqhQAZUp8/LCYr7U2eVIIC2g
         GCvOtMEIlIXWrlw4rxsS5qMqOVWFwfWCG2xzI6HyjhrYJrx/CCEvth/SNUWKxR1aX6sz
         5jJw==
X-Gm-Message-State: AOJu0YzKGOwVFx3RbGYYcAV5IN0fc0f9pHPwDk5fS+kO4H3zSgwpMedQ
        HxD9SFBR1xefG+Mi3kHzkjl25A==
X-Google-Smtp-Source: AGHT+IHTu5O309+spg7Mkh7rJrIe7RQpXLqzJH7gxYltD1c18fv1QejjDlS2KcrqmRaICnpgUTVxsw==
X-Received: by 2002:a05:6808:448d:b0:3a7:56a6:bd2b with SMTP id eq13-20020a056808448d00b003a756a6bd2bmr8913866oib.4.1692674168281;
        Mon, 21 Aug 2023 20:16:08 -0700 (PDT)
Received: from cork (c-73-158-249-15.hsd1.ca.comcast.net. [73.158.249.15])
        by smtp.gmail.com with ESMTPSA id p15-20020a637f4f000000b00563590be25esm7050630pgn.29.2023.08.21.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:16:07 -0700 (PDT)
Date:   Mon, 21 Aug 2023 20:16:05 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Uday Shankar <ushankar@purestorage.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Len Brown <len.brown@intel.com>,
        linux-hardening@vger.kernel.org, linux-acpi@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] Revert "ACPI, APEI, use raw spinlock in ERST"
Message-ID: <ZOQodU1CNMRtjYZ6@cork>
References: <20230822010933.2247671-1-ushankar@purestorage.com>
 <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 22, 2023 at 09:56:38AM +0800, Huang, Ying wrote:
> 
> ERST is mainly used to log the hardware error.  While, hardware error
> may be reported via NMI (e.g., ACPI APEI GHES NMI), so we need to call
> ERST functions in NMI handlers.  Where normal spinlock cannot be used
> because they will be converted to sleepable rt_mutex in RT kernel.

Non-sleeping spinlocks cannot be used in NMI context either.
raw_spin_lock_irqsave() will prevent regular interrupts, but not NMI.
So taking a spinlock inside an NMI can trigger a deadlock.

Am I missing something here?

Jörn

--
All art is but imitation of nature.
-- Lucius Annaeus Seneca
