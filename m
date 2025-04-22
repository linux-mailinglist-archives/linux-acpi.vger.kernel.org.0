Return-Path: <linux-acpi+bounces-13184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851EA96FE2
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 17:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A993B087D
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Apr 2025 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC828F939;
	Tue, 22 Apr 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6IV+lrb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2028F930
	for <linux-acpi@vger.kernel.org>; Tue, 22 Apr 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334185; cv=none; b=swGsIFZW80RGzgVfTlPizxw39Ud8Y/3YvLgZpgEbkPAQY7gmfKgxgHz1Un/44WHJ8veHYHOZRt+Fw8XyGnHDNggEdAHkF7pX9MLrak0V8AufFwy6hmbxIKjc/oB1kCbJpG3/9bqvJi4MUI7vgdG3NYeAvTEFbBgBMgv0/Vr/MFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334185; c=relaxed/simple;
	bh=a9oHiuIRd+Lat23wgyOLQVKu0davNOYNyV1lqgu94Hc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aPqEeTV4eLCudbxLMvU8No/l9810Z+FXTF9QYvvfHuyA7KEoOXi9wcBGzzmzR71S/1ncBcxe9A3hq1cNrFvCF631wvRaCYxVBLSDOO7lqpvAkn8PxRnt2ucoioaiN5IWsXxcjLSqSH8aiG3wwM/yjE2imnJvaDPHz4bYf460UoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6IV+lrb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-308677f7d8cso4887714a91.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Apr 2025 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745334183; x=1745938983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR743ev6ExzRYE8cINx+AM9cywgAmFfoIc+SqezuNJU=;
        b=I6IV+lrbYv0t+bvIaiG0TbVyWJT40Lj0vRqcLzc3/x+0dcZml1AnFM8HQY5Ii0wkCK
         EFI9GLLncA7Nf81PeY4qYgGpbEdk6GQtvjHUrP43uS7sYSItfs/Hp/W+equBtADhN9iR
         H8kGG/d5XAZylKSAL++q+ioYsECrBM0IYZU7VUdqcrJGhPa3joqiDrIgBusCnfsOOjmZ
         /a1Dr6t8bvSNSFRCHQvERf4r1hilrZRf/fX4p3Lkj5VzPiie0d1c69yQE2wP4ATTE3E/
         J6p2quspRGpvtugOYU1sLARWmrmhAeltWiFl33W2BwncgY4q3qCNTdFwpdJXyCO/Kkkj
         To3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745334183; x=1745938983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR743ev6ExzRYE8cINx+AM9cywgAmFfoIc+SqezuNJU=;
        b=E3Ypha65fDQ+8R2Zw8JLSkCFoo970n+p8QddoxFQd5eJgYRGyIin9mOFSmMsOB/RBG
         wPmDGS3c3Qd31YAiLjOYEvlk+J93HQ5THFKAC1Jl387RLs95C26KcD7km0kDu4pHMFZK
         LOsxBU/AyzP72tWQrkHzsq2MAC3Hcm9grCbW1VciLfNxi0DMTum73ASBY/O5eocy+i//
         CgJ/LR8vBKMbXKSsi63+t7xVC7TCNa27qa0UlgoILYM05SsFKN9WfHTDEES3YeSbdsSe
         LLlh/afg85jkxZEyks79ijSY9wt3/rcSxEN8LpMhxZKc37sIDNMSmW+QeCn7YKMPorNv
         DuvA==
X-Forwarded-Encrypted: i=1; AJvYcCU3r+Mz+ubLEJMira7SUmh/5j3uLMOT48W6HCMPr3zf+0XHUGDg/D1PUdti4RcIGN5FdX+Y4kvcWcE3@vger.kernel.org
X-Gm-Message-State: AOJu0YzA73vIRnVYgfSCDLkRNAMyJRb1OSSNzfASklSaPpFzIwJHclV4
	rAOlm8WJH54w4vqnQzjPC2qmK49VfcNtn6tuO4lMT+1daQI5uOv162c7cmYE5XjD2+0XhtJXcgs
	RnQ==
X-Google-Smtp-Source: AGHT+IEIapJZJRM9UWSGs3HX5eEFDXXhucM1QTXJfnPOK/9YTrDfsNmQubNfg9xjcSY4LHTjaYmG0pXn5/g=
X-Received: from pjbsn11.prod.google.com ([2002:a17:90b:2e8b:b0:308:861f:fddb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a0c:b0:2ef:31a9:95c6
 with SMTP id 98e67ed59e1d1-3087bb56439mr25794718a91.14.1745334182926; Tue, 22
 Apr 2025 08:03:02 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:03:01 -0700
In-Reply-To: <20250422082216.1954310-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422082216.1954310-1-xin@zytor.com>
Message-ID: <aAevpauKYWwObsB7@google.com>
Subject: Re: [RFC PATCH v2 00/34] MSR refactor with new MSR instructions support
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-edac@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org, 
	jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, wei.liu@kernel.org, ajay.kaher@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com, 
	pbonzini@redhat.com, vkuznets@redhat.com, luto@kernel.org, 
	boris.ostrovsky@oracle.com, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 22, 2025, Xin Li (Intel) wrote:
> base-commit: f30a0c0d2b08b355c01392538de8fc872387cb2b

This commit doesn't exist in Linus' tree or the tip tree, and the series doesn't
apply cleanly on any of the "obvious" choices.  Reviewing a 34 patches series
without being able to apply it is a wee bit difficult...

