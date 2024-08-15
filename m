Return-Path: <linux-acpi+bounces-7597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74ED952C00
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159D11C235D4
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40FE1993BD;
	Thu, 15 Aug 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzzTemNC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736613C80C;
	Thu, 15 Aug 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713521; cv=none; b=cmUitm8R3h7bnFby5mvZYINOjwSL+vtLaBdf3uiHkCA85waUHhq8fFc2ffPK+A6GAkAw5yybs5cPeOAVcN8g5EulRkwlmC7F+IJ2JcotNNvg5g1meUksuHpTRiLPBSXX/188wfDk64yqFCthp+6WtFfrp1MLhdn/U5u93RbMTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713521; c=relaxed/simple;
	bh=Vn/33MWONqQw9slQOdPWYKBhOYVMnF8T4GyznBvYU0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ois5FC5GLmb4vcW2dN43WuvSTHeD3l4VaMuEgftxxpVH8MGAC4tyhyqA3ypG2suKdelGPjjrM+00MRvUtPOhdoacisgdwL2iKN+GWWF7auvPH8sNb9dEBioSrVsTNiRVFzMYraz7fxa6u3CAsuTeXDr2cXAg3grktpTlZje/zQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzzTemNC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723713520; x=1755249520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vn/33MWONqQw9slQOdPWYKBhOYVMnF8T4GyznBvYU0E=;
  b=XzzTemNCKecOD3Ej38gqVqK0nVoRnMziI+RDOeUrtxqbAtO1ut1Kiwyc
   gVsBi8x8yiMyjqfFvJiNqzi5GijqkENQwY4yBkIQaiU5Uez0MTfTFFii8
   PdZnyTHnxko3AJSXeSUTV9y38TKnmM3ThqhVLw6aZySbl/pWhq++woRzj
   o5yemTRThMWqpzFAE4CRusoPXxRk4rtzRw21tO0JXZ594+xneReJ3pYjR
   zfF4J8x8uYImzOEjUvEzFVVkuEYSAVMpODD6I1EUsSsl4OcUA5Ln5MZ3+
   qmJJAQA9b0Ga6u7uBEjP7Y5ix+3cmbtGgymi4N1bLyA2MQh2pAMx6fA4A
   g==;
X-CSE-ConnectionGUID: 6bTJUHJ2RwWxZEhp061D8w==
X-CSE-MsgGUID: g5uKaAVFReSi1TjW7crcYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="22124144"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="22124144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 02:18:39 -0700
X-CSE-ConnectionGUID: DxkNY6K7QfCGjdGCUomwQw==
X-CSE-MsgGUID: B7jVgnBKTB6YXtsQJI21sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="89996985"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2024 02:18:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3AC9339D; Thu, 15 Aug 2024 12:18:32 +0300 (EEST)
Date: Thu, 15 Aug 2024 12:18:32 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sean Christopherson <seanjc@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCHv2 3/4] x86/64/kexec: Map original relocate_kernel() in
 init_transition_pgtable()
Message-ID: <6a5jgjdwnjseqxsxfzfcyflqyrpmzr7n5ki5haxc3e6llu5cbe@3lmi4qbfol7q>
References: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
 <20240814124613.2632226-4-kirill.shutemov@linux.intel.com>
 <Zr2dDKP4JuRUSOL3@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr2dDKP4JuRUSOL3@MiWiFi-R3L-srv>

On Thu, Aug 15, 2024 at 02:15:40PM +0800, Baoquan He wrote:
> Cc Eric and kexec mailing list.
> 
> On 08/14/24 at 03:46pm, Kirill A. Shutemov wrote:
> > The init_transition_pgtable() function sets up transitional page tables.
> > It ensures that the relocate_kernel() function is present in the
> > identity mapping at the same location as in the kernel page tables.
> > relocate_kernel() switches to the identity mapping, and the function
> > must be present at the same location in the virtual address space before
> > and after switching page tables.
> > 
> > init_transition_pgtable() maps a copy of relocate_kernel() in
> > image->control_code_page at the relocate_kernel() virtual address, but
> > the original physical address of relocate_kernel() would also work.
> > 
> > It is safe to use original relocate_kernel() physical address cannot be
> > overwritten until swap_pages() is called, and the relocate_kernel()
> > virtual address will not be used by then.
> 
> I haven't read these codes for long time, wondering if we still need
> copy relocate_kernel() to image->control_code_page + PAGE_SIZE as you
> said.

I think we can get away with only coping starting with identity_mapped().
But given that KEXEC_CONTROL_CODE_MAX_SIZE is 2K I don't see a reason to
change anything here.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

