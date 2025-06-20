Return-Path: <linux-acpi+bounces-14474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C78EAAE1A5B
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 13:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F827ADCD9
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B50728A1C5;
	Fri, 20 Jun 2025 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxR4oOzQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4B223DFA;
	Fri, 20 Jun 2025 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420573; cv=none; b=Zhezqhdqs5Zz1SZjZ1ULOJjAUwMeVZOn/SlGOVO0mFNuFEn/y3GgDB5E+qxFBpkNKbgSL7coQ6WMkQXhH+ZtRtQ9Co00NZB+Rf8WSG80S9O8aQryZ5Znmaw6/M9l6/lcI+N3dIrYshJ6gUv3hsAeOw9DXgk8SN18lvlmnCFJVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420573; c=relaxed/simple;
	bh=EHLl4d0QD68sdXBAgG6WT7Tdgd2xo2PXKgC8Tnor7LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhmalXnXupIOYCQ3yUuNQgEaJXLjBDN+HnP00s2UuLrmlWKQXkfsw/It1UbDv1PSabqdoik0Nmc1AUlrG4XqymLNfBNJS6QTo+LPEu8GRCbXDxauzvXQRtY3mMQtV+w00uq7WGy9uhygPKEBKN6U7q/wqGj94l1akPW/e51Gnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxR4oOzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A4C4CEE3;
	Fri, 20 Jun 2025 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750420572;
	bh=EHLl4d0QD68sdXBAgG6WT7Tdgd2xo2PXKgC8Tnor7LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxR4oOzQQJQ15Gm31XI9FCPgupg4s2bkDYqtEsv3nBEERk0tsVnK30lTg3M/XMPPM
	 Tr2Fncj057I5/NCgSx6Y0ZVxb6p1xVf2dpfpGqe5IslVitySAyi6P9axqmc43/HyT0
	 w2bTUrf0TPepMEXNMN2wSvC1ZtBfsjS0cWECQezWmP617KIwjRZdfbCJ2C26SH8uAc
	 UOpMfsjEx2TfuMkGAjCEkUPTdHpNHnmyTrQAiIM2cwg+mKHWff+gOzzBFsrZt0DUwe
	 UQ3gk8CvWzI5up08V0Rsi9zBqu5EK3uCtQ7sK9vrJ/n479TL6OdXiJYiO4Jw8b22NK
	 zJgP1ycQXJ1iA==
Date: Fri, 20 Jun 2025 13:56:05 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: ojeda@kernel.org, Rob Herring <robh@kernel.org>, alex.gaynor@gmail.com,
	rafael@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	lenb@kernel.org, wedsonaf@gmail.com, viresh.kumar@linaro.org,
	alex.hung@amd.com, dingxiangfei2009@gmail.com
Subject: Re: [PATCH v7 3/9] samples: rust: platform: conditionally call
 Self::properties_parse()
Message-ID: <aFVMVcYm0JwI5L6l@cassiopeiae>
References: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
 <20250618101325.3048187-1-igor.korotin.linux@gmail.com>
 <20250618131958.GA1550757-robh@kernel.org>
 <aFLJJkeFfHR9GB-0@pollux>
 <aFRP-vGMoZNmQZ2E@pollux>
 <ddcdc5ac-9c6f-4aca-ad66-37e1e66ef740@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddcdc5ac-9c6f-4aca-ad66-37e1e66ef740@gmail.com>

On Fri, Jun 20, 2025 at 12:30:37PM +0100, Igor Korotin wrote:
> Just to make sure that we're on the same page, I replace this:
> 
>     if dev.fwnode().is_some_and(|node|
> node.is_compatible(c_str!("test,rust-device")))
> 
> with:
> 
>     if dev.fwnode().is_some_and(|node| node.is_of_node())
> 
> And reworded the comment as follows:
> 
>     samples: rust: platform: conditionally call Self::properties_parse()
> 
>     Only call Self::properties_parse() when the device is OF node
> 
>     Once we add ACPI support, we don't want the ACPI device to fail probing
>     in Self::properties_parse().

LGTM!

