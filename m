Return-Path: <linux-acpi+bounces-14292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED227AD61AF
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 23:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4087B1BC492E
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBCF24729E;
	Wed, 11 Jun 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul/pH/Vd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E95247298;
	Wed, 11 Jun 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678013; cv=none; b=XgaLdpl0j85F2NsvU/ganVyexo1H5onaLUDLQKCm8B5jFZIxkLsFdGjmAzVLSLBVXArddeRWPzq66hozkd9hSrW6dBvZe203CQok0amT0vAxwsRtikBzV5WEylLs1YuJTTLH3HkWFCMuLn2IzFhMQXqchmjC7j7V0ApO11RWyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678013; c=relaxed/simple;
	bh=il4KkmPSp4Fb2vFI0Nud+eB0w5K1JXPkAcThSVRtqXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyxjSdBWVV8t8OTve+dAojY7i+UzhrWxecRjcWWaEZcOpT4MIjjl24eXMT4KuIGuDNDW2lBb34qXUu9pFXbQxa6YEolSHU2ldYFcYKqiGI4fxx4XZQ4/sPI3jVndvnGbhUkRtVZgPxAIfXZanY32exV6Bl6g1JhJXGr1dXbj1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul/pH/Vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DCBC4CEE3;
	Wed, 11 Jun 2025 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678013;
	bh=il4KkmPSp4Fb2vFI0Nud+eB0w5K1JXPkAcThSVRtqXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ul/pH/VdW3zjV04CmcPn0dQwIY7Zk9GSrp2vtfUgtilxgvC0NaIWEanM7vv9CAIjs
	 iGcajw86J/8O99xS9LFzhqevP4RNrowMSxAEBTk84F4S7S7yUM5pKN4txdfUz8omyL
	 6eRcBX6BmLos5dBTApx6oT+W4xCZCCR+w46BI9OFf1ucEA9L7Img+JeXRAUDTM9LFJ
	 Ye0u9tcIqrqgnJime/R6AYLrDlslp1I7UX0u/0kQq1KbC7Cf139EOjRGoUKVLRZvWq
	 4Q9d/VoRqa4njOZG66QWUwO2H4XEcPMQSB8HI0YRzIfNU1NshrCX3TGfHgH+FC9K8u
	 JeIBwGhVeI2fQ==
Date: Wed, 11 Jun 2025 23:40:06 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
	viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: Re: [PATCH v5 5/6] rust: cpufreq: Remove unnecessary `of` dependency
 in cpufreq example
Message-ID: <aEn3tqAZ1U7AQBvb@cassiopeiae>
References: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
 <20250611175353.803835-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611175353.803835-1-igor.korotin.linux@gmail.com>

On Wed, Jun 11, 2025 at 06:53:53PM +0100, Igor Korotin wrote:
> Drop the explicit `use of` and `OF_ID_TABLE = None` assignment in the
> cpufreq driver registration example.
> 
> Since `Adapter::OF_ID_TABLE` now defaults to `None`, drivers that do
> not require OpenFirmware matching no longer need to import `of` or
> define the constant explicitly.

This is slightly outside of the scope of this patch series and given that it
doesn't add immediate value it's usually better to wait with such patches until
the prerequisite is in Linus' tree.

However, if Viresh is fine with the patch and with taking it through the
driver-core tree and does not expect any conflicts, I'm fine picking it up.

