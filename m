Return-Path: <linux-acpi+bounces-14489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F8AE25C5
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 00:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B4E1C2022C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA6238140;
	Fri, 20 Jun 2025 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2HaO1Nn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2B19E98C;
	Fri, 20 Jun 2025 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750459203; cv=none; b=IFaCWpYiej4G5R26z8LNoAQNMyDbuUHk9lAhcXikoWO6q6eyw0PtXg6zR2cD9rZlENYeldfKM695B+6eQeBwMqNncOpKoBjDOnDGhPk8iHpJ+uj8urnGngKOxgIWvr8Y206nhRc2kjozrfUXCrI/jTGbGg6xpqo6QJctca0eTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750459203; c=relaxed/simple;
	bh=UJzf/Edj/55hCAfBsXh8EBKPEyt2L6fszDs5Yetv6X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCy3PAIs4VGLuqXjnIbZlBTOCXN2xx/7bqYCUxx5hyXN46Ed1Ti9SYgpa5t3mh3WvHSF0vEJJsbnd+rIwXROCEq0TLMQg1ob3lzYnLdd/feem5ZXpSS1JazkbttKl360U50jvdtTgTZ/XnhkMwWXoWcb6JCtU7H7thAcYN4P1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2HaO1Nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D78C4CEE3;
	Fri, 20 Jun 2025 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750459202;
	bh=UJzf/Edj/55hCAfBsXh8EBKPEyt2L6fszDs5Yetv6X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2HaO1Nn7StuX/qXCawUaxTa2ghi8SoP1/TzcWXWU50izuMWG5Q2V6EGILarefUgl
	 ixe1R5x4Xd5yOb1ihlBwyA9qu0nfvMeshXL0eBoe9Zo+OizE13isql/kD7gQlPde79
	 YVwiqnCjARxMWRQnrjWhXJxF3xelN9rxv/KbXB3SMSa7xAUTrqoh0oc+RVI3AHWiQ8
	 ZrnVCVwdlOUgJjIVWIMIlD+y/9BWKzZ/gYpxftZsoGhauI7rAx4nXBGLtrVwhcBdGM
	 zDe+b5Lqcr2Zmh/hyG/TJZ4NKMlMqHTNGV884qL0nhDs6DcESM+46XdUyLAjTQkxuw
	 QMRl7YUAp/yYQ==
Date: Sat, 21 Jun 2025 00:39:54 +0200
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
Message-ID: <aFXjOod7TGSFB7wC@cassiopeiae>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
 <20250620151504.278766-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151504.278766-1-igor.korotin.linux@gmail.com>

On Fri, Jun 20, 2025 at 04:15:04PM +0100, Igor Korotin wrote:
> From: Danilo Krummrich <dakr@kernel.org>
> 
> Implement FwNode::is_of_node() in order to check whether a FwNode
> instance is embedded in a struct device_node.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> ---
>  MAINTAINERS                    | 1 +
>  rust/helpers/helpers.c         | 1 +
>  rust/helpers/of.c              | 8 ++++++++
>  rust/kernel/device/property.rs | 7 +++++++
>  4 files changed, 17 insertions(+)
>  create mode 100644 rust/helpers/of.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f724cd556f4..1e918319cff4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18579,6 +18579,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>  F:	Documentation/ABI/testing/sysfs-firmware-ofw
>  F:	drivers/of/
>  F:	include/linux/of*.h
> +F:	rust/helpers/of.c

@Rob: Any concerns about adding the OF Rust helpers to the OF entry?

