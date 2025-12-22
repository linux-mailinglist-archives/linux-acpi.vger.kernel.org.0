Return-Path: <linux-acpi+bounces-19789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1ADCD731D
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 22:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C0C03001186
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F7214A8B;
	Mon, 22 Dec 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="n2eGqed1";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="TTsvd+Rx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E02AD16;
	Mon, 22 Dec 2025 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766439023; cv=none; b=KgyAJUOPQBAmeQ7Vcm+Ip9GB1LhfwYiIaw9p5chcInWo7FdJvp63BgApj5EifmH2MZgFrNkNtbSjXqa6l86IyXKGvR4DFV0emjV1UCJXZVQHY1GnCY3dTQ7MSyi6nqHf7HlXXUs/a7Nxtk8NQHo7XLRkWuesmBAo7/03xKCUwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766439023; c=relaxed/simple;
	bh=UK+O/YGbR4S45qIxMgv18NDC3kc6Bm815Ydj5c5LuHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY8yJPbMoqjAvzJhRY1hPZZkHo9r7w8J09ZPgEXV7si0dFt7SNKot+lDYUTRwIa/Qf1bAHfkKGhiyE0lYv31nKLzWLcP57det05EJQDSa+SF+l4RKZ7WiK02LXl+JUp9ebhE0Ho3otvNGx0tzkJdsGT/7P/tPLKsQs1ixDfjfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=n2eGqed1; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=TTsvd+Rx; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766439001; bh=AtBCnFEPLm1uhCIe6yOT+n8
	3ShUnMn9WdQMZkH3t0Hs=; b=n2eGqed1m/u/w+H9NzJpFMJAp7g1EXZqtST+ERgUVoXSQfuZqa
	ZsjBsQ/hN6AYcQkFpcGynOuHQw50RfiG0ZbbNrXDKECjpufxEQzHQm4KHPUjJRKjSoaUffyK4rB
	3QoqFuObmkRhH4yCwWyXXjxvsBNxM8YuQhhzbBGmwoNbNU+lOR8f1DupMWCrmoSb+8T+dnBo2E9
	emWxuR04xTfJNzDSlFHN+QI8c33ECgabUK6xVdjR+m2ftm9KLfxLheCCHt/4cuhnmHW7YBDolxx
	dHa+D3Ha9AzL3kTNDCBfVJt3rR76NAPz86DuI5mWpxL3sWwcjN3eQvGSomQFIzTzzjg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1766439001; bh=AtBCnFEPLm1uhCIe6yOT+n8
	3ShUnMn9WdQMZkH3t0Hs=; b=TTsvd+RxvW7Aefly0bLb0EbUZ0cEOTk+lfhxrn/gxZ4cV9ablQ
	sQc3pGIi64I3OibsfECSX07GtBcS7b6vU2Cg==;
Message-ID: <0983b1b3-f9b0-41b3-8cab-3d8ff2819e56@foxido.dev>
Date: Tue, 23 Dec 2025 00:30:01 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] rust: WMI abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@gmail.com>,
 Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <cover.1766331321.git.foxido@foxido.dev>
 <DF4Q36EVR4Y7.2MXOCNR87IPBF@kernel.org>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <DF4Q36EVR4Y7.2MXOCNR87IPBF@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 14:52, Danilo Krummrich wrote:
> On Sun Dec 21, 2025 at 7:22 PM CET, Gladyshev Ilya wrote:
>> Overview
>> ========
>> This patchset was developed some time ago out of pure curiosity
>> about the R4L project, but I believe it may still be useful, so
>> I decided to resume and post this work.
>> The goal of my curiosity is to develop a simple WMI driver in Rust
>> for unsupported laptop (I have some laying around) or, as a last
>> resort, submit a rewrite of redmi-wmi as a sample driver -- if that
>> would be acceptable.
> 
> It depends on the subsystem maintainer, please also see [1].
> 
> [1] https://rust-for-linux.com/rust-reference-drivers

Yes, I Cc'ed platform-drivers and WMI maintainer in a hope to gather 
their opinions.

>> Why RFC?
>> ========
>> 1. No real users for now
> 
> Above it does sound like you are working on a new WMI driver as well?
Well, I am planning to, but I can't guarantee any success at this point) 
So "no real users" is honest answer for now

But in a case if a) WMI subsystem is OK with reference drivers, and b) I 
fail to write a new driver, I will submit redmi-wmi-rs as a reference 
driver (since I can test it on my hardware).

