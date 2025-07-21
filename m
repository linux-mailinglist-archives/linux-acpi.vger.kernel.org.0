Return-Path: <linux-acpi+bounces-15251-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24FB0BF78
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 10:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDF6188C78E
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303022853EE;
	Mon, 21 Jul 2025 08:56:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA01F4C8D;
	Mon, 21 Jul 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088170; cv=none; b=KJnUQuS6sMEu6yOyjTEfQmhTD+BqxKJqbj9F++hLLGJJTEqTMl0heDzL8gMKVh6nin9xb93wmlav0NeD6Z8/gIbMJbRvOBmLGluTtSHg3P+lpN0Rtj1Q4PUXX4Ox1nXDhbxoKK3YQSJ9eVBzbanM3v+5S+u+VSBvWHEeXp/4cOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088170; c=relaxed/simple;
	bh=0Bp5A4Zfdt7s/FUBElE0pEEWRbgwFWQteCgTYa+GP/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1g7bFGZlxDwjHnAWNUAN+kfeAT1V5e0c9jaHi6SCv0WnLwsDj+4HCPpFJuixV4JeVegxlxOsRe5H0Ddtc0Xrqyq+LRUE6NWp2g1E9FdMhcceHfmgN90WiiHU23zoIDX7ztDQU5LyHUixTl4uiXjxYSaGwr3YqWwJPI/ywzicU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso7875807a12.1;
        Mon, 21 Jul 2025 01:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753088167; x=1753692967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a+mMHsMlXSHJfvHPELmbgN6W6iJdxKKlOu5d6bzUb0=;
        b=Bp3/Pnr8pxnRBklDcUwJnli/pyVzrY94Thfr4WehSUYwRPTngglVM/RcoeDj4lMEY4
         BAvyFoL0KGSmbej4Tfn3RECwAiUhQLxdfp9QL2pErheuy1SYnywTNzgtxDADRcAHqHIo
         dL9///R3Np2sfkaIdFsrTF0cLQbiJYFFLDSZK+WmqJIjgUJTeAJ/TGjfs0dRDXCKNfIx
         NuVMuA6IBWlXKXpRWO6f//sst3fT9PK5HwcLlIKeWf0jGUc0aEdduOvZW1SAD6cSrDRw
         2l57gVj3prZm2kEfr/ugey6NZ8WnzbE6/mVxpOMQ66miQKM37beXazNNYK3+BQ4xIfp7
         lbuw==
X-Forwarded-Encrypted: i=1; AJvYcCU60ljKIXi5pDK4Il8PdK+D9IXlUN7XvY0TN9cqqMCip7k786lxVoSJIGs4JGJNnCk/eZCyPf3DqCJU@vger.kernel.org, AJvYcCVj2m6pDDWfPG0QiCjQirL9sfFRpKuHktTay83dDYOOYGOvhgjdTUjwg23lgAoFQEwRn1XAX5jcNIqtqAyA@vger.kernel.org
X-Gm-Message-State: AOJu0YykUdn+3+h/Ky3QOClfdy2cCXXvfREpqqkGIKQgmNNIP0ApPvE/
	/XAPa6OjxgB/nhkjEyq3dXxPzdbqOuiEK98HvU4uw0+FiDAyLHqkc2Sh+LCq1g==
X-Gm-Gg: ASbGncsnGH2J0j+TYv5WxHzVdaUARSKeviXFHEUgMD/vc68+z3L+8Ue02mzxXq84Rq1
	0MzjZT6Ejk9DFtHRrmTQ3xLSeUlomxTjcb02+OumQYxvf8w/EzLzzJvRB3NZP0dZ156LowwV2/z
	Rm5k+9dop80wkCzJJlyCvNW5aiHf8DWrs+knl6VgtxRX0wntQt6PaELrvqIixcSmny6TgzK/vl8
	R34NsyKhs0yTDCqH0TOTSDJPvyZd+kQtJrRCQgWjNLWbgB/IqNJTRN/bpWXy4vgYCyGi36dAPt9
	dpvYoRflEjJxCP1p3mFoNHsWoyoSgU8/2sdPRY2S5vm96HDbIR42TsiYlZaFbfiMMpzB7E6E1vn
	c63hKvMKhRVVbSw==
X-Google-Smtp-Source: AGHT+IEO4SybCFLnv0FdYsHmbgrbP3TZ+2cOjGcDGUgtwCXqHHCS19zQvONNtXYlZVgWK8Y/lPeVZg==
X-Received: by 2002:a17:906:8c2:b0:ae3:f3c1:a5dd with SMTP id a640c23a62f3a-aec4fca259amr1202375766b.61.1753088166300;
        Mon, 21 Jul 2025 01:56:06 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79e16esm636036866b.15.2025.07.21.01.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 01:56:05 -0700 (PDT)
Date: Mon, 21 Jul 2025 01:56:03 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, 
	"mahesh@linux.ibm.com" <mahesh@linux.ibm.com>, "oohall@gmail.com" <oohall@gmail.com>, 
	Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>, "osandov@osandov.com" <osandov@osandov.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <yk7ocbvfb7hswfdi2bft6lkatonn2ulu34kz44hypjwdagzeos@g6lmdncwrqhl>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <kw7mwmca3ir4nfyofumqiack5sht3aisdchevykdtmlio6xo7z@5xbdibpqvqix>
 <SJ1PR11MB6083CEAB23FCE85937DC5403FC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <mazejvrglvtqdfsevduahqxvlvjv6hlo3apivossn2jnxpsuds@os6kxmmsq3xt>
 <SJ1PR11MB6083D08A2F94FAEE5261AA6CFC50A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D08A2F94FAEE5261AA6CFC50A@SJ1PR11MB6083.namprd11.prod.outlook.com>

Hello Tony,

On Fri, Jul 18, 2025 at 05:36:50PM +0000, Luck, Tony wrote:
> > I found that I don't need to expose the metrics in vmcore info at all to
> > be able to read them from vmcore, given crash/drgn can read those
> > symbols.
> >
> > Global variable hwerror_tracking will be write-only during kernel
> > run-time, and only read during post morten analyzes. I am still not sure
> > if the compiler might not get rid of them completely, given no on reads.
> > I am wondering if I should EXPORT_SYMBOL_GPL(hwerror_tracking) to avoid
> > any optimization there.
> 
> Thanks for fleshing this out into a patch. It looks very much like I
> imagined.
> 
> I'd be amazed if a compiler did elide all this code and data because it
> noticed it was written but never read.
> 
> Is the spinlock when logging really helping anything? You weren't
> worried about locking/atomics in your original patch because users
> mostly care about zero vs. non-zero (or maybe vs. "many"). If the
> count is slightly off when many logs happen, it may not matter.
> 
> The spinlock doesn't help with the timestamp part at all.

Agree, precise number is not important there, and if there are
conflicts, it will not hurt the message.

Let me remove the spinlock completely them and send a new version.

Thanks for your support,
--breno

