Return-Path: <linux-acpi+bounces-14291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B6AD6149
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 23:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104A03AA7B9
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 21:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C77243370;
	Wed, 11 Jun 2025 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7pE7J1Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CC242D84;
	Wed, 11 Jun 2025 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677346; cv=none; b=mss2RMUet6c1gvfXC83MB9tkC1VkVk3LjhuIil7sARWjx8Y7cf099gzjI0eP1v3nPBQVZP/8zt+BrU7qd/z8aqkTlBqBTAMJHWVJegFqtlBFcttr47BMi+TtZpc8mkM+McvlRAnnWFSIlZbZz1Ev12K27iYloUA34ng3W6OSrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677346; c=relaxed/simple;
	bh=VWqoiXH2JdNHFgQIgLtArNjcYrlDmkCix2JsN/3wK3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUNuFL429zkjquxwPsyPEEFcXSjKfH9AZcwbDYYQpTLfHRdAxQkTNz5Cs55Nv/WWDyOswavzDci4morRacO/FFbDhAJt1s0C0WeSrkjD1nuJO1Nqx9dHS5bBHdwdjUVO5vq3fHAw6DYc6Y4riSyKScx7c6pBrwtq4RtWNCpDrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7pE7J1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B1C4CEE3;
	Wed, 11 Jun 2025 21:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749677344;
	bh=VWqoiXH2JdNHFgQIgLtArNjcYrlDmkCix2JsN/3wK3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7pE7J1ZjpemXgxYODwMuQZy+YBTX+3kllnmEqCbEXoXUQxJtHgw3469yVl0YXRCI
	 WNnS1AI52ZXpB3EL6KAJEt4kctj2dGBhevK8ORF+8j6A2aI4Wl1XBFC52IYAm3pSYV
	 Qvm/Gb+cO3Y/hNxm5hC9qS5UAprxECUTxmm8YycCzJ8GQCq2kZ9ZlI9nu2bm8b7Jn2
	 WKxwRaJB0vhD/3FGhoX91MtSSBTtF3QeSMh46eISVlaecqPHAzSBBJLqU0ua+nEPl4
	 b5cdB5CLGT4cHtlRB5p8bOBI1h5Hkx5lyiHxVYPrPpEem8+gtBidDFllEmPcQrG4jp
	 jtT1HgT1zH6sw==
Date: Wed, 11 Jun 2025 23:28:57 +0200
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
Subject: Re: [PATCH v5 4/6] rust: platform: Add ACPI match table support to
 `Driver` trait
Message-ID: <aEn1GbRJpUwMd7xc@cassiopeiae>
References: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
 <20250611175121.803370-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611175121.803370-1-igor.korotin.linux@gmail.com>

On Wed, Jun 11, 2025 at 06:51:21PM +0100, Igor Korotin wrote:
> @@ -162,7 +178,10 @@ pub trait Driver: Send {
>      type IdInfo: 'static;
>  
>      /// The table of OF device ids supported by the driver.
> -    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>>;
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;

This change is fine, but it should be a separate patch.

