Return-Path: <linux-acpi+bounces-12047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778AEA5A66B
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 22:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267C8188BEFE
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 21:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4811DF258;
	Mon, 10 Mar 2025 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW0Hvhq1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A21D514E;
	Mon, 10 Mar 2025 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643337; cv=none; b=r4+UYg36WyGbL+COPstzd3u1as3x9ndQc0abgEPcs0YZM4pXV0t+wfwqbF+4suaNUoq/SXkp77ClaClvK7B8YTkBy61TcROLIglEjoRX90DaOy2rxFe0myJRQEq5M5NyBiyMwYeghAIM4rpFA41mfipNuvT6CghthYuWNWuz3wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643337; c=relaxed/simple;
	bh=lGP4O8/b8RrW4V398IUyX8VSSi2eJzmwutyPzwQF06I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgsUmNI6MExRI7S2zz9Xt3q44iQSCcWFSRulB2I6jka2BeePqvTTwSYunHhIBFaUlVnLL1omuEyMFA7RFF6l1T7D0ZJ9r3lTAPs7udpKNPoZ7JZvuAicB3GdNUI7ZjeloUr/co/7LV0O79oNcgJDqJObClsnQuMxbStuHX6Wf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW0Hvhq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6A8C4CEEA;
	Mon, 10 Mar 2025 21:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741643335;
	bh=lGP4O8/b8RrW4V398IUyX8VSSi2eJzmwutyPzwQF06I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lW0Hvhq1DrTExJ1YyluCwie6TV2rCph8uTSl3SAlzizZ5YhzWlhR63zjiGbdv4IHB
	 zc0KdEh4bALUK0g/JV7ZSyxgoMGfTCyokGFwJ2ZeoM2azYBDcsgc8cMfizRu7ZMod6
	 u5W3nRfA2t9f+j91lAQDOIXGgaQ5bE1sjCUx94KyvdWHoDcAKMrL2ITsvAqUgPiv1P
	 uZ0gf138yJHWoaB00C6pVWUOPvBgaXsK1OKqqKpRuKtyTyoGFj4qgUasfKZoc/7L+7
	 zHGLLNEyxsR5Qx5n77s3AfsTCCJ+ssQhxgDgQ0DKkvicAzjqWK3AvHkmT7oVKC1Cw5
	 1XgYGDgvSU4bg==
Date: Mon, 10 Mar 2025 14:48:51 -0700
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hao Luo <haoluo@google.com>, Masahiro Yamada <masahiroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-acpi@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alice Ryhl <aliceryhl@google.com>, Tejun Heo <tj@kernel.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jens Axboe <axboe@kernel.dk>, Chen Ridong <chenridong@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Jann Horn <jannh@google.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler_types: Introduce __nonstring_array
Message-ID: <202503101448.1A6978F79E@keescook>
References: <20250310214244.work.194-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310214244.work.194-kees@kernel.org>

On Mon, Mar 10, 2025 at 02:42:48PM -0700, Kees Cook wrote:
> In file included from ../include/acpi/actbl.h:371,                                                                   from ../include/acpi/acpi.h:26,                                                                     from ../include/linux/acpi.h:26,
>                  from ../drivers/acpi/tables.c:19:

Ugh, this whole paste went poorly. I've fixed it locally. It should be:

In file included from ../include/acpi/actbl.h:371,
                 from ../include/acpi/acpi.h:26,
                 from ../include/linux/acpi.h:26,
                 from ../drivers/acpi/tables.c:19:
../include/acpi/actbl1.h:30:33: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (5 chars into 4 available) [-Wunterminated-string-initialization]
   30 | #define ACPI_SIG_BERT           "BERT"  /* Boot Error Record Table */
      |                                 ^~~~~~
../drivers/acpi/tables.c:400:9: note: in expansion of macro 'ACPI_SIG_BERT'
  400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
      |         ^~~~~~~~~~~~~
../include/acpi/actbl1.h:31:33: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (5 chars into 4 available) [-Wunterminated-string-initialization]
   31 | #define ACPI_SIG_BGRT           "BGRT"  /* Boot Graphics Resource Table */
      |                                 ^~~~~~

-- 
Kees Cook

