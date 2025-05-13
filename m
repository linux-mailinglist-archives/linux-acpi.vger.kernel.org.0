Return-Path: <linux-acpi+bounces-13703-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F8AB56A7
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 16:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783154A3D94
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77291E9915;
	Tue, 13 May 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2ubNbqy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592721D47B4;
	Tue, 13 May 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144882; cv=none; b=J2jyRrk9WI6kqpRAwbqrlbFHrn0ZGqnLiZSdNX92vPN3WTsC+duvIYSCdMWrLczEnhSCFtsDfHIOBzNCy1vJ98U14IMPTO4GNeKQj3uXLjmzcqMO6PArfvTIKudsqSM2a8Ior+tRlQVwOE4j9LTZQvsD7vWWGiSZppJ1T0fhV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144882; c=relaxed/simple;
	bh=jUGK0MnhCfAAXhuEwPjCMG6LHrz012CuJWOJ/DmpeVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QP/yzvipFA8/UcZkh9Yb3CThR26oTG0nfz5D5UTEG1IdBnpm9xKxc3kVA5CcSLdpuRM01JSHNcOz+BxKO6tZ6faAf7mVkDo5v0iCWQHbSgdmJBiFI0SHbFcDYHLNTKK1hKAX8QTZTOJZLs14YOwgpZes2MUwHUl6/Ec/dYmapRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2ubNbqy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70a23f4fe8bso52183767b3.2;
        Tue, 13 May 2025 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747144880; x=1747749680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myBVHObkWyQY3+5UnR6s4iPAJCP05aofkHzUTmt6WZw=;
        b=I2ubNbqyEShEa4+dW0/e2xidIbRMNDpFlWycCNLYBKhwrSz3pCBMm+4GAF1fSlkAn6
         ulaJ3F6SMPYGE1HoBaeOvWkyQJh6Z1xuPmbgnFQJw22+2kS4SDXu5wbuY6Quo4epKM60
         CaPeeRYjg12vwnlHu1U/C2QA30EAmF0bLDlnHRKaDSUbE48TTT1gPevniRClaB4boQZV
         8z9YOm1H4AJ4fCEmKKoCEt1vHIuZ3T5/i6awWK23R45i1FWdZx3B4AGT7O4rKytVKGpM
         jtfZMWC4ba3HhB8DelVaGWk3yE5fVJQBRGNTJtVCyUPHAQx8H5r01+GQtcbVCRXd94k6
         tm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144880; x=1747749680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myBVHObkWyQY3+5UnR6s4iPAJCP05aofkHzUTmt6WZw=;
        b=OglZTuNyZuLxLjvpLyLM/WIJfG9wKtNjsQzSHXsZ8FtSiHoGjZGzFrLxPM69o+CU5O
         nsMxcJwpBOLHHuazrvtVkjwKfwpNn1DFAFtKPlqDXTrgvxOld0fc6P3xvoG11soUZGHm
         oNcn8CwxqMgZnEhtVxybxj2N4OSLvUphy1SxA0xTko63QKGRA8qA0kTeNOI3OlSN7rC2
         oSxMCV0olId0OdLwX/+lzCSwmMeP11CE3yhpVw8MVO+l/b1iuKGTnAhV8W30TUbhrVNS
         87Urqlo0e/zWor29Wo6FeKF5ifeIcEFc1ujlYCqf0q7QkH1DaKrOtu+zrq2lGkHBpMQI
         JS9A==
X-Forwarded-Encrypted: i=1; AJvYcCUgPpnLwEZpDaSc+Q/bwu84uGgrRE3x6EIiEa/Iv/QMgTNh/B1HXrhH6bFO8+IrrfJ+3fTO6/y4653E@vger.kernel.org, AJvYcCVfQBM5z+hrTZt93XtSZrPBZCCfxL5dnl6wXR9WLo4OVrtPKjQmVHsiAy97noAVx/moRWXmV9i7rmXe8M1W@vger.kernel.org
X-Gm-Message-State: AOJu0YxayhPY22BoZ0HKarWQRlgb7/WE6czr7hDykMsy5FM81NMep427
	rwJ2n9nmYXevof9YTfRHwZq+uQizjNywXnzDkxzLOUxrQtJgbVkd
X-Gm-Gg: ASbGncuBwE79TuVovhf/VntrtgTulO2PxUiGcJMNQJRaInstDZOcntY1I6kpqzne2r+
	BoIIYbA0U4oXt/2+6ixf+LgU0yXn5yXPRafJkvfEOl5pcGHSjhvmn4RjO3Tx1Djaz/XAW5N4V4c
	qFO52iXUuCL145oRHYSwemGtfMiz43IQQoTsmPU2Pb0S4TZvlS0W0oBx0aReOxFHEVMUQxXvxZS
	/tCZg1gve4g5CNpsVGmyGM8hYWyCnV5l5MFpFv8lQKi6dFMnRFtenuAQKD3gykZJAFSaTlS4vHv
	2DfSVrArqjAWZWW0tCCVsvqs11lpn41+GWKumEQcnmAiOw+p46o=
X-Google-Smtp-Source: AGHT+IFiZKthq2Ml6dSOkF0GGY8tdqtCnFKdhFM8W3K+YKPqOfB/ANdvWqEZJk5f0YHttBzxu1gXNA==
X-Received: by 2002:a05:690c:640d:b0:705:750d:c359 with SMTP id 00721157ae682-70a3fb36f8amr245436137b3.32.1747144879834;
        Tue, 13 May 2025 07:01:19 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d9cbcfesm24338287b3.69.2025.05.13.07.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:01:19 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	gourry@gourry.net,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Tue, 13 May 2025 07:01:17 -0700
Message-ID: <20250513140117.2925329-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512152944.eab80697d7404a803f9f65e6@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 12 May 2025 15:29:44 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 12 May 2025 07:25:10 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > Andrew, I'm very sorry -- do you think you can fold this fixlet in as well?
> 
> No probs.
> 
> In future, something a little more formal would be preferred, so I
> don't have to write your changelog and forge your Signed-off-by:!

Hi Andrew,

Sorry about that! I'll keep that in mind in the future : -)
Thank you for being patient and helping us with this patch.
I hope you have a great day!

Joshua

