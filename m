Return-Path: <linux-acpi+bounces-14574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D5AE7101
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 22:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90C41BC031A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B8256C7E;
	Tue, 24 Jun 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3HOiJ7/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D12405E8;
	Tue, 24 Jun 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798005; cv=none; b=PqOrM5CTuf0sTAztlzp78ZQauBpHlDKD4hboNFQbn/Vr2CR5UeXm4kqqkUZ9BK3Bt5aqjkeVJ4/oKR4JlVEPjK+1++uWG/AcABTmtY7bXUnVpLPAuN74YBoTbHg1DLKuQYX/oQV+P+tuH4x/rokZ/4knJL2RPTiihpvulML17Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798005; c=relaxed/simple;
	bh=JE5izUwd5pMie06/3hvl6LkV32U8BqmlJuVS9TMGxOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pms2O0q5/OKMwLvAbhveCU+wkal6x3ehU4yQORtqUDWPQjVSmVd3cV4sedUPSYDiGv88VOzmuc5izlyFrtbqSclH2e52gPNao8SBXMIyzc+JuLT8HcoIf9zMXz4xvYpPAvqGsillMLpdWJugWhBhusENsWNIkLnwkWExphT6+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3HOiJ7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27284C4CEE3;
	Tue, 24 Jun 2025 20:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750798004;
	bh=JE5izUwd5pMie06/3hvl6LkV32U8BqmlJuVS9TMGxOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3HOiJ7/Pketlpzx1szq3pDyKSCj7y+3Y2bzV7iH0qtrVzJMWdq7FoyevKRfFGwKc
	 1vKM7Zt7D7+L8OYp7KiGPnO751xceQjJpvK1ZWQTrdpTs0l2Jk1BZAF5ybVRtSePEx
	 AJsgkjExx4qFbZ6/UwmSd+9xDXfQkEekEh7l0fMh6eZnIt42aJpXcI52smpNQaIOBb
	 ItOaCLV6sEIAtNOXnpTlpJnpf24KrcF9Rk7Rg6p+kLR+AR71wGf9a+YOBBQqACa7DF
	 cRXUc1//xQPMuQTqYey+QzKOj1H3nBm7TYZDezzWW++QohnCF2XLu817kX9+Tih5G/
	 Rze5A4n53qjWA==
Date: Tue, 24 Jun 2025 22:46:36 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alex Hung <alex.hung@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Remo Senekowitsch <remo@buenzli.dev>,
	Tamir Duberstein <tamird@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>, Len Brown <lenb@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH v8 1/9] rust: device: implement FwNode::is_of_node()
Message-ID: <aFsOrAqpBtz9OAEI@cassiopeiae>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
 <20250620151504.278766-1-igor.korotin.linux@gmail.com>
 <aFXjOod7TGSFB7wC@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFXjOod7TGSFB7wC@cassiopeiae>

On Sat, Jun 21, 2025 at 12:40:02AM +0200, Danilo Krummrich wrote:
> On Fri, Jun 20, 2025 at 04:15:04PM +0100, Igor Korotin wrote:
> > From: Danilo Krummrich <dakr@kernel.org>
> > 
> > Implement FwNode::is_of_node() in order to check whether a FwNode
> > instance is embedded in a struct device_node.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> > ---
> >  MAINTAINERS                    | 1 +
> >  rust/helpers/helpers.c         | 1 +
> >  rust/helpers/of.c              | 8 ++++++++
> >  rust/kernel/device/property.rs | 7 +++++++
> >  4 files changed, 17 insertions(+)
> >  create mode 100644 rust/helpers/of.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9f724cd556f4..1e918319cff4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18579,6 +18579,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> >  F:	Documentation/ABI/testing/sysfs-firmware-ofw
> >  F:	drivers/of/
> >  F:	include/linux/of*.h
> > +F:	rust/helpers/of.c
> 
> @Rob: Any concerns about adding the OF Rust helpers to the OF entry?

Given that you proposed to use is_of_node() and rust/kernel/of.rs is under your
MAINTAINERS entry as well, I assume this is fine.

If not, please let me know.

