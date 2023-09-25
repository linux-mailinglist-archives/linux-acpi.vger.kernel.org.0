Return-Path: <linux-acpi+bounces-110-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176887ADEC1
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BDD8328162C
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F25224C6
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:30:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA91F61A
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 17:13:26 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1131F139
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 10:13:22 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565334377d0so5206068a12.2
        for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695662001; x=1696266801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8AVXr6vllU577ND8JQi6s5Wb2XnBxy1FQk2gXYImts=;
        b=nwdwXGckYPlPX21pEof3xnvcqZtcLo+KJ3+jVK0axkL3B9r8vRWYdHvuPmYQG+0SMW
         0kplhw0TQhtU0Iwi8LNa4wT1D+uBm3rl8SZyA+8Yw+2aNjTVr3NIha6HuMFqSvToYIPN
         2KvBec9sl1KfxAXU/PbYcm2nl3P/IgqmPDnkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662001; x=1696266801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8AVXr6vllU577ND8JQi6s5Wb2XnBxy1FQk2gXYImts=;
        b=Fl3U+kVV7lR3kiqGfwCZoaeVMZN/unfuyyxU5BLPCK01clKRaYw07KzNSGWWZkRSrq
         vFC+aJwA1c//zk5z+p6fzD7V5UaeX7cmRo6n3n090HEK08jbaR/uUF0SR2Y2QUxAuIt1
         OompAg2kkjAfJnIz6XtJaMqMeGLsWuqqfiRaD4uduMUKLaEOg9T4yod4EJ/Upnu/1NSW
         CrT8xPksOwtgVr7wcQuPGpJgpjwwcCoQz5Kb5eVnTMLlF8OEboWiRoNz/uFIbv/uPzDJ
         ypP1jRwZbNaTRaztgBstXvINk0d6Wegr9kJWVBm4ULQRXRnXUhgukhR3jdEBvh9C9j13
         XMUA==
X-Gm-Message-State: AOJu0YzZIghW1uy/LLxTJFHVoljwyiki7iCAfBeXnSk20uS4tvSMW1Hg
	Ntg7GYzGhwH05eESzj03KbQS3A==
X-Google-Smtp-Source: AGHT+IHWl3AN866Dif5RDGSG6cKkeY0zzlRZ9iz5O7jZ3LOhJATZBUXvLNzYu+Ccp3gZwtb6gOE9uw==
X-Received: by 2002:a17:90a:4e4e:b0:268:f987:305f with SMTP id t14-20020a17090a4e4e00b00268f987305fmr6859749pjl.46.1695662001491;
        Mon, 25 Sep 2023 10:13:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00268b439a0cbsm9146846pji.23.2023.09.25.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:13:21 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:13:20 -0700
From: Kees Cook <keescook@chromium.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
	robert.moore@intel.com, linux-hardening@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	baolin.wang@linux.alibaba.com
Subject: Re: [RFC PATCH v2 1/9] pstore: move pstore creator id, section type
 and record struct to common header
Message-ID: <202309251012.AD87704BB@keescook>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230925074426.97856-2-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925074426.97856-2-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 03:44:18PM +0800, Shuai Xue wrote:
> Move pstore creator id, section type and record struct to the common
> header, so that it can be use by MCE and GHES driver.

I would prefer this was not in the pstore header -- this is a backend
detail that should stay in backend headers.

-Kees

-- 
Kees Cook

