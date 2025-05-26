Return-Path: <linux-acpi+bounces-13899-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E76AC40A4
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 15:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654A63AD863
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658A1E1DE2;
	Mon, 26 May 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeFwupQW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398B20E00A;
	Mon, 26 May 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267208; cv=none; b=ZB0NWStRESY8ReyjCleNB0j+b03gMG57FXXDL3iSirMScg11qY9u72zLZvdjg4V4bE/Ykby9FEwDnlyOyWVcvZDZyMVWo6IhmgH1jdaOmWjX9yQo4MDaIY94SZM/4TVOkIePk5Q3e8FqTG+lC1tzgP+m13BmmvCJlIHDH/Yc5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267208; c=relaxed/simple;
	bh=gEIcXbeyJylzemFfm58X30GOjXDyhHO6XtAq4kotWx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQnvHCZLou3SewAUpGKZ2kuAv7uOI9HpPTjkTMAF+tMsP2PmjdZwfbKtN71B7x0y1IajHNGGRaxgnOjswbo1ClioAj4e+sicbGfguavQZlBKenauapls+bGuXzv5DEXA7F/T9N0m5/gBU5TFrROXgBkxACavdg2RVpEEBZAt+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeFwupQW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so14206165e9.2;
        Mon, 26 May 2025 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748267205; x=1748872005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEIcXbeyJylzemFfm58X30GOjXDyhHO6XtAq4kotWx4=;
        b=EeFwupQWE1wqoFx2PYUH6axCdwkJOkdH3zckqyAdokdsHvwGqDLINWIAE4mLNts2jk
         c+msyjARqIpZhHl2MaBu3llANsMOUgXeRy9WYMx5oldt0l0+fHs5s5Di4C43+f0Hktj6
         E7blTLAsPvEKM21KiVX29RHgbXOiOWtUKid4qCKZMuMj0oFAKuPGmP8UPxHSVIgEAwBP
         9zFYTRPRfRGOp/UiIE8o1JMI8sPKyAsKcry6iqQBuQqDnDMsIB6U8q7R8P7PuueONSIx
         hCltMajhGSIzeqTd/jp5XQHNQeKLkaRvGT+6d5LPBenR2Df7H1yYeR/VktPfwa7kYCKn
         zBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267205; x=1748872005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEIcXbeyJylzemFfm58X30GOjXDyhHO6XtAq4kotWx4=;
        b=nm+sIpYrr/1SXae6LvNZMB8SyQP5g0Z8QcQDldv9I/SA+RtvQDiWIMAnlwGFZ1jvBw
         ZQPJIuUlThzZscTrbo9z7j8J+kUxDuwSpPEyb2tAT2HDJ9t9XPz4Hl0PiRRYJntRAkiT
         wS+VOWzB/NTnIqEMCKySTa6JwiipfJl7w7F5pbI4xGy2nlSppIk/GnOYsS1LrfAlVSEs
         Aiw3wRIqUIbqsYokkLzh0yGOnzAbZlc+56KGLV8b0+KJBKDFm/EQ7GDTaMvgyAqluy5H
         k0SlaSp9tX7ZhnpxPV2d9Qrnpb7Av8/xBt4rmFXfquhbvpkw9IJFxV+V9BXf44JPJUZx
         QEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4answNTcpXtnUpW8GOuuTfWRqqhgWsFJ+tyLXt+FLRrFOwyYFs4oMsYkv47VQ6owSpEzpenthr6fL@vger.kernel.org, AJvYcCUpFoBGmq6XnTGMtPoerpvGTeSbq8kZKN/fg1xNQYiyqLk7Fi/EXT9Pj6StDeYp9ieBsP6xCYvhsubVb/Ov@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8JDy2Wp0E/jRD3cd1zmgdfhjemyIpEqn4j+YuW752w0IPuRA
	M3fBLDgQj8co3V9CPQGSSCoq/4BsuV6SK7yA38z0PLWushnO96RIdpSP
X-Gm-Gg: ASbGncuzY7jfKp3eA4G/Bl0cygS57THLspcktwrFAFtg+xm8COfQzwar1tlfKh3aoqj
	9yKVNEEAWFk8N0trErQUBrIPBTE2wQWEFBo/rB2AMDWt4csRMvCjH/OwZXq6bj3RBJWiDy27376
	iYbqIqra3+4jW550PJJeGZiQWsnOzJ1UqpIE99L3pLFj/vIw6z+851MWvQt5L+P35lDkoU4dhIy
	zreUYWJww1ifa2jSQ2onGQIv1RiNsbJclxZB0wjYUMCbYwB00ksgwk59Xebqyzwc6KkaapM7Yb/
	nBvFkxBEbLLQP+sanE6b2kw+TC3YPPAqmPLlDOLu9r5sEQh04lYAHnIsDNBdv+SEAg==
X-Google-Smtp-Source: AGHT+IF0w9TRTgFRE1/w5CXqazhpiPGG/3gemNBKdnwqA3lLvRBETofTT6VO4WQ+GxGnfbleVvKptQ==
X-Received: by 2002:a5d:64ee:0:b0:3a3:6e44:eb5f with SMTP id ffacd0b85a97d-3a4cb49b40amr7421372f8f.46.1748267205141;
        Mon, 26 May 2025 06:46:45 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3edcsm244864055e9.20.2025.05.26.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:46:44 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: peterz@infradead.org
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	khaliidcaliy@gmail.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	rafael@kernel.org,
	tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH] x86/ACPI: invalidate all cache lines on ACPI C-state transitions
Date: Mon, 26 May 2025 13:45:33 +0000
Message-ID: <20250526134600.619-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526120029.GR39944@noisy.programming.kicks-ass.net>
References: <20250526120029.GR39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is absolutely insane. This day and age, nobody should use WBINVD
> ever. We've managed to not do this for decades, and I'm thinking that
> either the SPEC is 'mistaken' or otherwise out of line with reality.

> If you hate performance, and you want to break things like CAT, feel
> free to put this in your own kernel.
Sorry, i made a mistake, i meant ACPI 6.4 and 6.5. I already resent this patch
please check the resended one.

