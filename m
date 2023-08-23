Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0DB784EF0
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Aug 2023 04:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjHWC57 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Aug 2023 22:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjHWC55 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Aug 2023 22:57:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51701BE
        for <linux-acpi@vger.kernel.org>; Tue, 22 Aug 2023 19:57:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68bbd45d0d5so153242b3a.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Aug 2023 19:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1692759475; x=1693364275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SME2DvVs9blfVZ8zp0UdPxu1cIq3MKtc4ha5tK0NIgE=;
        b=Dc43MJfwdq/zHsEqQTPdiV5xt3yUy+e3JQfRi5iw1Vw+aVJTTv7wDZ4vU9Ob58TgvO
         g0DQCqkPLPbhj7EloC8/TgyjQNchqYGZmNg15sfi97uZBXK5SF/C0kB6GWOTnLNtS5Rd
         SYlBQW5YUI7Y6PlI7atNU/FrK7x97CT3yYT8K9pf+inhfJDqxMMlR8pQ00k6cBL536UP
         6A/+QwA/q7Z6LK+4BJq/m88KgWto5WellkAaurFPclmsmSWG+LasupQMQcipdeloYnJF
         AXgKgoswHqndKxC2nLvKeqxGNLh26cCO5rWDy1NUEw92+TZESe97+D3lZhz7YVZZkY8A
         smHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692759475; x=1693364275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SME2DvVs9blfVZ8zp0UdPxu1cIq3MKtc4ha5tK0NIgE=;
        b=T+zc01fwGdaDY1KAJqoIUJKVDRkB8+3EAZnI+TD+A+gIM6qgYmFR2GuFipCFxiE6GQ
         /9Y9XCdy0Ou5KdscBNaeEUwMWK4yN5OyGTzqk1KTiv3GxdZcJM4ejWb5FxCCuJMHHLOv
         ybpVnvxxUR+ppZ5EfwXpi9RJvKbjWNLtQe/MdU5V9V5zIrXKlEOkrLDjf7/8dA+ACCY2
         KqMXC0PhVxxVdtPVFhXMauHq3GzooSegWBYHZlbgV+HDKqNru1XjKp7nqneHURtm09Wc
         7THGK23LWTzHaCVWJ6YeNWwge/MV4WLJmW2aVdowI63JA6yTp46ViU+fLnl3tehzoDm+
         Hv+g==
X-Gm-Message-State: AOJu0YxISSWEn7Q8rhc8TEfEDOIcbqG2siqyBgjBwuJGKilScCq08TQU
        /vPkMUldIV/qM7fyF2akZt1edA==
X-Google-Smtp-Source: AGHT+IETEsIrTDXLxEiI/YnaIkMEbWdsL7+oyfU8ciOMH2G5fA1n2mxqzx4MukdySCJwnBdfmv8lYQ==
X-Received: by 2002:a17:90a:2d8b:b0:26d:414d:a98a with SMTP id p11-20020a17090a2d8b00b0026d414da98amr10374180pjd.1.1692759475083;
        Tue, 22 Aug 2023 19:57:55 -0700 (PDT)
Received: from cork (c-73-158-249-15.hsd1.ca.comcast.net. [73.158.249.15])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a198300b0025023726fc4sm5448007pji.26.2023.08.22.19.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 19:57:54 -0700 (PDT)
Date:   Tue, 22 Aug 2023 19:57:52 -0700
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
Message-ID: <ZOV1sM8xZ6+P48Z1@cork>
References: <20230822010933.2247671-1-ushankar@purestorage.com>
 <87y1i3c015.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZOQodU1CNMRtjYZ6@cork>
 <20230822234522.GA2590891@dev-ushankar.dev.purestorage.com>
 <87cyzebi00.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyzebi00.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 23, 2023 at 10:38:23AM +0800, Huang, Ying wrote:
> 
> Thanks for reminding!  That's a good point.
> 
> Checked the implementation of rt_mutex version of spin_trylock().  One
> possible code path is,
> 
> spin_trylock()
>   rt_spin_trylock()
>     __rt_spin_trylock()
>       rt_mutex_slowtrylock()
>         raw_spin_lock_irqsave()

You are right.  I'm actually quite surprised how we turn a trylock into
a spinning lock.  Now I know, thank you!

Jörn

--
"Security vulnerabilities are here to stay."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
