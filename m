Return-Path: <linux-acpi+bounces-10993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62FA30157
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 03:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F817165558
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 02:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B571B4243;
	Tue, 11 Feb 2025 02:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hOYdIsip"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6311943AA1
	for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 02:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240106; cv=none; b=AdLQxy+ZIx+SVA94fziwye2wszaZEetwBw5/oO/ALBk4jFyqPuKBKwU91v5jzcVYC5ETQOo1bL7UcRyVgZUn8xmzxXmLTyB9lOSUpMACnIkHCAGTuhkBsr2qUVDGyK1W9HQT4Eu9JUTcDGtd4jGmaNjgdrm0n6G+5UnL7nvKDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240106; c=relaxed/simple;
	bh=POlFgsEsVb9+B8eu6oMuEZauFgviS1fEuhNz1SMWWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWK1O4HetJEZlp9m7hMaIjOiZ48vDkAcz/VOrIl+/POUH4HBET6RJ+vDkU6zI9XKUp6mG4QN/BiDOmcs4fDou3gy4K1amTxG/iPALEwMyrFviFtxDyO3zgXq3kLMXm107sTAQaxNqIkKMchNkpoJpBgWZIR0OT2snPaFFmjf9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hOYdIsip; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46c7855df10so95452561cf.3
        for <linux-acpi@vger.kernel.org>; Mon, 10 Feb 2025 18:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739240103; x=1739844903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2gxFs3tfFYKHyVYTpvL17LkDysO2OVKxxWn8KTpAXk=;
        b=hOYdIsipqtV5wJIv8Mf37i1w/ppf88GwbmEU2YhkrzS3aQZhxKM6Olq0oV/betv49n
         NJMkyo6EJTkeBMeLfo5rIE2cacc9me4DWk0SnqSiibsrNJJ7CWP+Ht+guwgkLYbcZbwK
         OiPfs/MA2qAJUmJMLqNfsIxPvEfM5yM8/ycd/JUyEGSxKJnOZNwWo+D2NQLgQo+O0KCo
         ZhMRqTX5Dn1aMuFl8w/fB71iqIHrpTcyarVcPElw+h3mlvY7QhZk7aHgE8UBC0tjTkBM
         k086qvgtr6kPc6Yu8lUGi+WkM79cfEaXpMu+ZziRuQ8uIaLvf2OiAHcZmW9S9Hfq3uVc
         6c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739240103; x=1739844903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2gxFs3tfFYKHyVYTpvL17LkDysO2OVKxxWn8KTpAXk=;
        b=iBVeOezrgbetKYWcXrbGqSU6PzjXs4MM7U6hb21G5P2CW2WWMlYFi8fn/NUt1MsRy5
         K+quSZX2UGpphpQnRy/3iIMHgcCim5nYmriFA+PIzv/mBaLejm8XXzb1BiYmhpc+4TMF
         VLit6mGCvwZNzUm0wEGTYqKryTJtcp4p4oXWP1CTN3fEdV2O9mXYwrbL5BUj9DGf9DHj
         +4KN3oe3jTJV48PEpSjTtB19Pkshq3chXfIqH9/Ig+XMayUgz7CMbWqfXkV9LbUQpsPp
         stRdp+LIr+J7B9psB2R6KM6xQUdJVhUa8PGDtvdFOZf5nwTG1rChJTbm7BsOhUd+NPKK
         Zf9g==
X-Forwarded-Encrypted: i=1; AJvYcCX9mTyVNHt5HKPUauZeO2Q14BXn1nT6qzdAT0TYL1ivTLXHViT3oZOwOyQ+e1W9LRzGrgiPlieslOWg@vger.kernel.org
X-Gm-Message-State: AOJu0YxTatQYvsiq0uVrrev1uTUQQ1lqmwRLEAjlfJtLMsM1uJr2F1MF
	yaswt0pIvXODS7ytw45mNNmKF/Lq4FvuZ9CtBLNLVcGhf6sGM21/fZrNlMUYdiw=
X-Gm-Gg: ASbGncsD9avc7QGsaYueUFoQsNVGtY3yjQGwPlVbLQE09BTAVFwqcw6G7YMgPryQJWB
	QOpVTGbU8Uf0rAvPUEYKlZX4mjnTe8WQSIK2yBe/ZFcsMaIaUZI5xXuP2bsL5t+d6RLNeMqIWym
	YrjXsLzJODG1RW+a8iEboO2QHuXcvrm4Q+njLWxnZmhVYfPkcXlMx2JaxoPt2cBy7rU5/mNAGiX
	/8HX6oSSxnrL2Edxozn5BJfnbARsWR6cftUaPV2v8Y7LIOODX9KqUFRithl81ifoja09PVXghTC
	GgJflTe2tHuhJhY5v9YbjEjcEFWKaKgELBC5rpxjc05pKuoMfavNd8kcZUH3cenO8hOOnCgZnw=
	=
X-Google-Smtp-Source: AGHT+IEfvXpY/tplh7KS1jPYCPst0iTC1lg9LCaiKWRQOE2BUPYfi4dAoAFQOz0a/z0irSMYiTy/QA==
X-Received: by 2002:a05:622a:30b:b0:471:a083:f3e4 with SMTP id d75a77b69052e-471a083f4b5mr31004531cf.4.1739240103182;
        Mon, 10 Feb 2025 18:15:03 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec2e9sm604168685a.20.2025.02.10.18.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 18:15:02 -0800 (PST)
Date: Mon, 10 Feb 2025 21:14:59 -0500
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com, honggyu.kim@sk.com, rafael@kernel.org,
	lenb@kernel.org, gregkh@linuxfoundation.org, rakie.kim@sk.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Message-ID: <Z6qyo5q5QMpEJrie@gourry-fedora-PF4VCD3F>
References: <20250207201335.2105488-1-joshua.hahnjy@gmail.com>
 <20250207182009.7fc099c3074ad00338f25e0a@linux-foundation.org>
 <Z6mQUIAOTvHj3wSp@gourry-fedora-PF4VCD3F>
 <20250210163941.15da1e935ed47aacf810fdd0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210163941.15da1e935ed47aacf810fdd0@linux-foundation.org>

On Mon, Feb 10, 2025 at 04:39:41PM -0800, Andrew Morton wrote:
> On Mon, 10 Feb 2025 00:36:16 -0500 Gregory Price <gourry@gourry.net> wrote:
> 
> > On Fri, Feb 07, 2025 at 06:20:09PM -0800, Andrew Morton wrote:
> > > On Fri,  7 Feb 2025 12:13:35 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > > 
> > > Leading to... how do we know that this patch makes the kernel better?
> > 
> > Just focusing on this question:
> > 
> > The default behavior of weighted interleave without this patch is
> > equivalent to normal interleave.  This provides a differentiation
> > out-of-the box, and that's just a better experience.
> > 
> > We may find the default values / calculations need tweaking in the
> > future, but this gives us a good starting point.  Anecdotally, I've
> > seen an "optimal" distribution of 10:1 based on the numbers run
> > sub-optimally compared to 7:1 or 13:1 (but better than default mempol).
> 
> How was this optimality measured/observed?
> 

TL;DR: We used MLC to observe highest sustained bandwidth.

Unfortunately I can't post exact numbers at this time.

To simplify the results - HMAT reported bandwidth often drifted
+/- 10% compared to real observed bandwidth. So the distributions
produced by auto-configuration were mildly off - but not by enough
to cause performance degredation, we still saw higher sustained
bandwidth.

When testing the manual configurations I saw that changing from the
auto-selected values to a few ticks in one direction or the other
resulted in *slightly* better results. Not too surprising.

So as long has hardware doesn't lie horrifically, which might be a
tall ask, auto config has a good shot at giving a decent default.

~Gregory

