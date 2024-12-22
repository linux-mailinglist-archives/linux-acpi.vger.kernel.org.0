Return-Path: <linux-acpi+bounces-10270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30949FA6F9
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6801666AF
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40B0143722;
	Sun, 22 Dec 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PCSMLRnr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B42A1AA
	for <linux-acpi@vger.kernel.org>; Sun, 22 Dec 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734887008; cv=none; b=Y/HLRLQn2tdI8vj0pMdcbEfKnt9tVw+lQxYHBnptesdUCTQmGUq/1jmq4N/hJTGK4D0CRZq5fpLal15oaUDZBBX8Hz6aK2B0+dQoKQkeN0gYezDkGZlIQ7x7hjajq4t5jtdEGXqEV2iy0gEozkEvHtxgifYI51gcGYxo0+wi0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734887008; c=relaxed/simple;
	bh=IflVJ6J9XzbXYmOLhpidkZjoAwBqPzc+2r/K98T3J/k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgPZaizat0THpzP/ikKx2fOH/lhRfn3DofRzmVrr+l8plVOBo/AA1ofGzcHPen33zu1F9VC1eabTQ62LyfdCwV8nGGVnjnzEI/B8ncCB59Bk/LOAHnQ/cIQiDIETF0O63227xsOmDH9b5tH7hkubdf7zFy7VshDvotgked4lsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PCSMLRnr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725f4025e25so2751564b3a.1
        for <linux-acpi@vger.kernel.org>; Sun, 22 Dec 2024 09:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1734887007; x=1735491807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcOdHdWrcugtyWcHoCfyk0R8M1W+7zds2dEJm6C+mDI=;
        b=PCSMLRnrhXM9s9SJPWjAm2Rz44mOJvh4Pdu/US/RYn9MtiBHaWgDHtFRAJl9205NlE
         CGiTmNOn6MUnk0CqOklW5By9NjUmR/HvAcIexrz5M/seFxwRY8Ag6p4Cg0+DDFa0iazX
         jHd+Oka3MsXUGKboIVGiaI67FFNZ/CCxNVxgMCiB/FcTCalMThYHTNV3Ey7Dn9CtoaaR
         ymOP/0k5SwDp3D2cxuH0B0lM151PbfvRSv/6edDp+8PQHDu+AguQxhxnCEEBlrKcscut
         2miQ6o0qS0CiDSjaVQE6FxayIcHPd9MJRbiqKFFVHj5m7OADEtp+IwIs6p2IhS0W/uyC
         N6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734887007; x=1735491807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcOdHdWrcugtyWcHoCfyk0R8M1W+7zds2dEJm6C+mDI=;
        b=lgArnqFuf/h4OsS5/Lt98S/2uxl6cOvL6HuUaWgWoBqQZBka63byO9xId88Zit4X9g
         1p23R6vE0FJqyWNygGih5BGO0zuKyVqOzCAXBO0sXiyt36MQxtLTs2tqCtUJ6vIahZ0V
         os6cBsTgXwHMI3PasOgQHO8FrIn/YEluqDEUje8jcGK0sNHRJwyQTtoZD4qS5UXjGEe7
         VxCo73Z4jQKKshFx+BEaFo7+Xc9JaUQyyTj9J4nWYDpnLfUVbtr6vEFca9wFM+TsbFd+
         YpVb38lvlEP/pQpwCMvET0Ig+t4McICsTg1ZkE9YelSTFt6iysy1uyksYFVaiON6F/IJ
         z9oA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0V9GIeWNoyMekAiH7QEY9neVfg+YZ7Vm87PVqdMBOOiz1lTCQcQjeGIznvBTfflHb854KLKYqiCd@vger.kernel.org
X-Gm-Message-State: AOJu0YwmZG9t4n212kA0nhO0PbSkHVi5iNjbd1Wa3E0R77EI1pPGquEZ
	AaPvLpJPDJo8k8NaoCFg/PMFKcT7EEaDocAg+q7ENczCGMa+jDLP8vDqdN+Lpyg=
X-Gm-Gg: ASbGnctS8jQXdsNtZzLYve/KBjTRrDWgXdWQS0zxQEi5TOwjTcsV0BUqbCNmI/gOr28
	MFP4Q8hHkToV6f99G+iG4U+wV6qC/PBFckZ1e726+Y4J7JMoeC+9dxVSY0n5GyduPWSQGaoF37g
	eJGR4Dq8fTuJwOSKZTHdZkYstajjcDRIx1EntJNal1FpSKuX50m0iHwhb72usj6+PXWFHT1U1N3
	Xten02NYLMjCovzdOsudLjOsUXknSAieFxnELph3FopMcawXAnslCOKgZbwbeftN9xFmbdP5G0F
	sK24sOk=
X-Google-Smtp-Source: AGHT+IHyDRNtmt1EM6O/D9w+dg7/VuoeBXOzeAbhhFbYiVHsrJa0pCNJI4n5WSuy+0/pLWrop6UFLQ==
X-Received: by 2002:a05:6a00:2449:b0:728:e906:e45a with SMTP id d2e1a72fcca58-72abdecdbfdmr16342619b3a.24.1734887006789;
        Sun, 22 Dec 2024 09:03:26 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([75.167.163.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad831160sm6343053b3a.59.2024.12.22.09.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 09:03:26 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
X-Google-Original-From: Gregory Price <gourry@gourry-fedora-pf4vcd3f>
Date: Sun, 22 Dec 2024 12:03:22 -0500
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Hyeonggon Yoo <hyeonggon.yoo@sk.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	"gourry@gourry.net" <gourry@gourry.net>, kernel_team@skhynix.com,
	42.hyeyoo@gmail.com, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Honggyu Kim <honggyu.kim@sk.com>, Rakie Kim <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH v2] Weighted interleave auto-tuning
Message-ID: <Z2hGWoqZqwxJC4gM@gourry-fedora-PF4VCD3F>
References: <20241219191845.3506370-1-joshua.hahnjy@gmail.com>
 <3682b9cf-213c-497d-ab81-f70e1a785716@sk.com>
 <87r060i3nn.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r060i3nn.fsf@DESKTOP-5N7EMDA>

On Sun, Dec 22, 2024 at 03:21:32PM +0800, Huang, Ying wrote:
> Hyeonggon Yoo <hyeonggon.yoo@sk.com> writes:
> 
> > On this server, ideally weighted interleaving should be configured
> > within a socket (e.g. local NUMA node + local CXL node) because
> > weighted interleaving does not consider the bandwidth when accessed
> > from a remote socket.
> 
> If multiple sockets are considered, what is the best behavior?
> 
> The process may be cross-socket too.  So, we will need to use
> set_mempolicy() to bind tasks to sockets firstly.  Then, it may be
> better to use per-task weights.
>

If we want to revisit this, we might be able to make task-local weights
work without a new syscall, but the use case was not clear enough which
is why it was soft-nak'd originally.

vma-local weights are arguably more usable, but require the task to be
numa-aware and probably require a new mempolicy syscall because mbind
has no remaining arguments.

recall my original testing results from stream:
https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/

Stream Benchmark (vs DRAM, 1 Socket + 1 CXL Device)
Default interleave : -78% (slower than DRAM)
Global weighting   : -6% to +4% (workload dependant)
Targeted weights   : +2.5% to +4% (consistently better than DRAM)

Just some context
~Gregory

