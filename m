Return-Path: <linux-acpi+bounces-14373-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD537AD9912
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Jun 2025 02:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156393AA53E
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Jun 2025 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3662D566A;
	Sat, 14 Jun 2025 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NxBxlxoE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F97BA33;
	Sat, 14 Jun 2025 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861226; cv=none; b=b47M6ETRnNDBNh6nS8VrNC3SAErAiiuSKtrlHcIpi0AF8Qy4E7du/vwxIEXaZFspVE916wADqNIYiFnRsZwgilzzmn7xC3f5QfjJ7uXJd7TWNl4CuEb/Kgf7vgUjOzqvJazpiTILX/a3oieWeHpQVLf4pOeF9HIwonaS6Td//as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861226; c=relaxed/simple;
	bh=Amvs3Luk2aA4Ri+Z+WtskuRg9fDppnYMUjoOrkGgVbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3snAuUbSKMS1R0AoxenyRfHo0TuwVIHiuyzhrYgTvWr7FK1SecielaSrEY+MRzlYjDBw9QuM2NlQOqbb/FHDfmiyFoXyNsA07DZr9oYP16Y747JoIxoA1EqlKr7Yl1hkw8ucmxkir6uIgbmq1IT6XBIsRtY2LpecJaVltbB4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NxBxlxoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01892C4CEE3;
	Sat, 14 Jun 2025 00:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749861225;
	bh=Amvs3Luk2aA4Ri+Z+WtskuRg9fDppnYMUjoOrkGgVbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxBxlxoElxULFRktcPXheHA+ZhwM+HzsqYZuX8z6zB4t0Qp58HcLUeFpynStULZ5g
	 atUcGPqdRjW5wBbIB5kZzC+VenLzfG0+GpZfTg1E7SQz2YpgtagjcgPAYVb1Dc3VFd
	 BU9RlTRfzh1DUOz+sGA0BHjgXYvgF6INszYDq6dg=
Date: Fri, 13 Jun 2025 20:33:42 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: marc.herbert@linux.intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, rafael.j.wysocki@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <2025061313-theater-surrender-944c@gregkh>
References: <20250613191556.4184103-1-marc.herbert@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613191556.4184103-1-marc.herbert@linux.intel.com>

On Fri, Jun 13, 2025 at 07:15:56PM +0000, marc.herbert@linux.intel.com wrote:
> From: Marc Herbert <marc.herbert@linux.intel.com>
> 
> Fixes undefined behavior that was spotted by Jonathan Cameron in
> https://lore.kernel.org/linux-cxl/20250609170509.00003625@huawei.com/
> 
> The possible consequences of the undefined behavior fixed here are fairly
> well documented across the Internet but to save research time and avoid
> doubts, I include a very short and simple demo below. I imagine kernel
> compilation flags and various other conditions may not make the
> consequences as bad as this example, however those conditions could change
> and this type of code is still Undefined Behavior no matter what.
> One of the best articles - there are many others:
> https://blog.llvm.org/2011/05/what-every-c-programmer-should-know.html
> 
> Since commit b5ec6fd286dfa4 ("kbuild: Drop -Wdeclaration-after-statement"),
> it's now possible to use C99 declarations; the kernel is not constrained
> anymore to group all declarations at the top of a block like single-pass
> compilers used to require. This allows combining declarations and
> definitions in one place - like literally every other language and project
> does - and trivially fix undefined behavior like this.  This also reduces
> variable scope and avoids misuse between declaration and definition like
> uninitialized reads or writing to the wrong variable by mistake. C99
> declarations also allow using a lot more `const` (the default in some
> languages) which avoids some misuse after legitimate use.
> tl;dr: C99 declarations are not just a "codestyle" or "taste" issue;
> they are an important (and not mandatory) feature.
> 
> cc --version
>   cc (GCC) 15.1.1 20250425
> 
> for i in 0 1 2 g; do printf "gcc -O$i: "; gcc -O$i nullptrUB.c &&
>    ./a.out; done
> 
> gcc -O0: Segmentation fault (core dumped)
> gcc -O1: ptr is zero
> gcc -O2: ptr is NOT zero!!!
> gcc -O3: ptr is NOT zero!!!
> gcc -Og: ptr is zero
> 
> clang --version
>   clang version 19.1.7
> 
> clang -O0: Segmentation fault (core dumped)
> clang -O1: ptr is NOT zero!!!
> clang -O2: ptr is NOT zero!!!
> clang -O3: ptr is NOT zero!!!
> clang -Og: ptr is NOT zero!!!
> 
> int faux_device_destroy(int *ptr)
> {
>   int i = *ptr;  i++;
> 
>   // Because we dereferenced ptr, the compiler knows the pointer cannot
>   // be null (even when it is!) and can optimize this away.
>   if (!ptr) {
>     printf("ptr is zero\n");
>     return 0;
>   }
> 
>   printf("ptr is NOT zero!!!\n");
>   return 1;
> }
> 
> int main()
> {
>   struct timespec t1, t2;
>   clock_gettime(CLOCK_MONOTONIC, &t1);
>   clock_gettime(CLOCK_MONOTONIC, &t2);
> 
>   // Use the clock to hide zero from the compiler
>   int * zeroptr = (int *)(t2.tv_sec - t1.tv_sec);
> 
>   return faux_device_destroy(zeroptr);
> }
> 
> Fixes: 35fa2d88ca94 ("driver core: add a faux bus for use when a simple device/bus is needed")
> Signed-off-by: Marc Herbert <marc.herbert@linux.intel.com>

Great writeup, but as Miguel says, this isn't needed at all, the kernel
relies on the compiler to be sane :)

thanks,

greg k-h

