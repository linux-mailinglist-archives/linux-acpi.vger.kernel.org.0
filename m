Return-Path: <linux-acpi+bounces-7610-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9B95425B
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 09:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1CD28D2C5
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD6A8563E;
	Fri, 16 Aug 2024 07:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kfPWJs8z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE078C68;
	Fri, 16 Aug 2024 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792000; cv=none; b=Oou9XUrHZdtHN8tpvQsmo2zg76IqnpYZGwtwcw+RovvlMDP4cTZxVcPtEEKy6LxNREcQYUPLN4rJZsXpkenmWyNhtsYkWRAfQYLV0ORzL6KaDhUEuDHTR4a9WBmJry9P7su/k8VY0YfhaY+4YI4ew3yBJ2WloCK0vLzvCilaBYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792000; c=relaxed/simple;
	bh=3J0NRytEsTukDgVOmZIAUw6cxnJT3AnHuFYMxFXR5/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlSoQyu8MuMHxQ2CzQVW3gJNAFcn14mY+CDoyyJhFoUMesv/fjCJ6xawBnQ5veXy6wKf0y5ThfK3WDJpjpvV9/uwiGZ7yzXJpH/ev38bcs94qa0XE8EAFAbourbCR0zUYPh9aieeLJzNKI2sxMQZiAqpH2R7lImLqTDN3BqyRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kfPWJs8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8D4C32782;
	Fri, 16 Aug 2024 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723791999;
	bh=3J0NRytEsTukDgVOmZIAUw6cxnJT3AnHuFYMxFXR5/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfPWJs8zN3LV+ovFZqYb0GyUraQ71cmPjiIK6tzsmYps0Y3h8KC8jP0BSNEGa85If
	 PA1nwWfnYzoUpg4qZOog9cj+0KVJ5pan7CmMu9PFVrSCwwleavd29aHezUmAHAezBV
	 S0637v2hVxRNlGTV4O6/xJtFEo3ERTxShj5VhqMM=
Date: Fri, 16 Aug 2024 09:06:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Robert Moore <robert.moore@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org, Metin Kaya <metin.kaya@arm.com>
Subject: Re: [RFC PATCH 6/6] rust: cpufreq: Add rust implementation of
 cppc_cpufreq driver
Message-ID: <2024081634-excluding-squeezing-c386@gregkh>
References: <20240815082916.1210110-1-pierre.gondois@arm.com>
 <20240815082916.1210110-7-pierre.gondois@arm.com>
 <CANiq72mjvE7h_aH5tYnuuzdPHAzDUpioMi-h44HNCro8qFfDSw@mail.gmail.com>
 <1605d622-faf5-4535-bd71-ba514ee102dd@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1605d622-faf5-4535-bd71-ba514ee102dd@arm.com>

On Fri, Aug 16, 2024 at 08:59:22AM +0200, Pierre Gondois wrote:
> Hello Greg, Miguel,
> 
> On 8/15/24 15:04, Miguel Ojeda wrote:
> > On Thu, Aug 15, 2024 at 10:31 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
> > > 
> > > In an effort to add test/support the cpufreq framework in rust,
> > > add a rust implementation of the cppc_cpufreq driver named:
> > > `rcppc_cpufreq`.
> > 
> > Similar to what Greg said -- is this intended to be something like a
> > "Rust reference driver" [1] for the subsystem?
> 
> The initial intent was to review/test Viresh's patchset [1]. I then
> thought it would be a good idea to implement another cpufreq driver
> to see if the provided interface would work.
> As the cpufreq-dt driver is re-implemented in Viresh's patchset,
> I thought it was also ok to have this driver.

Duplicate drivers for the same hardware are never a good idea, we need
to learn from our past mistakes when we have done this before (hint, it
did not work out and we ended up dropping the duplicates.)

However, if the subsystem maintainer agrees, they are free to have
duplicate drivers, as long as the maintainer of the "new" one will be
there to help out with all of the confusion and problems that users and
distros will have :)

good luck!

greg k-h

