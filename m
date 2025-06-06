Return-Path: <linux-acpi+bounces-14198-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F7AD04F2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 17:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BC71716AD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B75E1DE4C4;
	Fri,  6 Jun 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHe0HCfa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239045009;
	Fri,  6 Jun 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222879; cv=none; b=umX9XfxyjUonr82wbOfhkVwCtrtpxloeJrpHVY1tIe2B/flpICP+h7BE30ME9qfeSRi5t7oXuVyKC4tGlgh1A4DKYbAxJxxL17UUmDxLL3ETapqiYonCkvv1+OO2RYL1jt6iOtPppNjfbU1RLmCGoOytgY9cbQvgMut06fVjUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222879; c=relaxed/simple;
	bh=i6FYWVz+2Y+2+RafxhFes1KyUuzU/moaSG0EciA6/jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmtRUt1W9F4BZH4KDoscOCbbjTV51ZKS9F91fVDm796r9ZE542oKPSdnU4grjVweGiukIFV2ygh4kcl4SemfcoRQWf1pHcjgm99OWRSWKGiZLHrKNW+A0Wye5XYJhn+uzjOiq3hM+ETBdTyne4C+fpHO8b41RlfRWS8uS7uwbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHe0HCfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29FFC4CEEB;
	Fri,  6 Jun 2025 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749222878;
	bh=i6FYWVz+2Y+2+RafxhFes1KyUuzU/moaSG0EciA6/jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHe0HCfaDw7jxWz7zqEzpf9IvXPUJLEgJ57nu7o+6x2rCp98WEHH+TVYBt1rJ1vb6
	 ZTN+gDHKZXor+5KWdz4m42ekz4xEKsnfaV/vprfAKFgMj17DwjpwxmUglVtcjh/DSP
	 0S/XEMWsp4bV0+2KcBX1R/rOLLfrTGXcuv2da/DZ10erAbeCTfgGNDwBUn8rVaBBgG
	 ZoxoIAxmCE13Q696nfS8e3PrA9inYXIH2iRAxgk39jjIdHhcadxkuGc6mbbYsbm+61
	 DWHBJiVPkX3OfsT2JY8PYIHaERkvNtZz2q8KeX8utiDsnmjoOD9DpuO2mGcAnryF4B
	 qgGxe2rlsu5Vg==
Date: Fri, 6 Jun 2025 17:14:31 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: Igor Korotin <igor.korotin@yahoo.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>
Subject: Re: [PATCH v2 3/5] rust: driver: Add ACPI id table support to
 Adapter trait
Message-ID: <aEMF18wLMoCNAxFN@pollux>
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
 <20250605162726.3659792-1-igor.korotin@yahoo.com>
 <aELyEqg0GrkC8oZY@pollux>
 <CAG7QV91AWpOk7VUcE-B1MLkEQPDB0Y=zsBOBf6MhHVYh1aEGQA@mail.gmail.com>
 <aEL76mgHSZG5idW8@pollux>
 <CAG7QV91kkVqE2BgB5VpmX7QST25VDCqr+9zNx1Nt0-fuwp9t=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG7QV91kkVqE2BgB5VpmX7QST25VDCqr+9zNx1Nt0-fuwp9t=A@mail.gmail.com>

On Fri, Jun 06, 2025 at 03:58:11PM +0100, Igor Korotin wrote:
> On Fri, Jun 6, 2025 at 3:32 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Fri, Jun 06, 2025 at 03:26:13PM +0100, Igor Korotin wrote:
> > > On Fri, Jun 6, 2025 at 2:50 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > However, I don't understand why we need this and the subsequent
> > > > is_acpi_device_node() and is_of_node() checks.
> > >
> > > The idea is to avoid unnecessary table lookups when both OF and ACPI
> > > match tables are present.
> >
> > Ok, that's fair -- let's build it on top of the FwNode abstractions though.
> 
> I'm ok with the FwNode abstractions. Just to make sure I understood
> you correctly:
> I'll need to wait until these FwNode abstractions are pushed to the
> rust-next branch, reimplement what is necessary and send v3. Is this
> the course of actions?

Not all Rust code goes through the Rust-for-Linux tree, it depends on who
maintains the code. For the FwNode and device property series I pointed you to,
the code is maintained by the driver-core maintainers and hence will go through
the driver-core tree [1].

(You can always check the corresponding entries in the MAINTAINERS file, they
document, who maintains a file and which tree changes go through. For
instance, if you want to know this for a specific file, you can run

	./scripts/get_maintainer.pl path/to/file

and the script tells you everything you need to know.

In general, before submitting patches you should run this script on your patches
to find out who you should send them to.)

However, there is no need to wait until the FwNode and device property series
lands in driver-core-next, you can just fetch the patch series from the mailing
list and build your patches on top of that.

If you do this, you should make sure to mention the exact series you build on
top of in the cover letter, ideally with a lore link to the specific version of
the series.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/

