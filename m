Return-Path: <linux-acpi+bounces-19849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9CCDE029
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 18:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 929EF300661A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A049253340;
	Thu, 25 Dec 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Nbs+IDNr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5AC3A1E94;
	Thu, 25 Dec 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766685444; cv=none; b=LiX9ac7VbvQmfiYTcXv6YJaI1PN/CinYw4YSuIqMersRFvpLk8qH2wr9ToZKnrr4FynyarDE4vGa58MXqNGBRWfpPOYiI/0RIcgCYelANW1XD7ijNIGHzUJm9jBibaj8CsjSivt0++bl4lj4dTulohRbbhb9e+i9ZX5AbU9uBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766685444; c=relaxed/simple;
	bh=SlTKS7S/P6wLUsnsBLPEZl39VLlpxmFf1Zt7tpFyAOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSIqpKYfJL9GdKUZ639TFOiy+LdGTUxDb7alQ2w0ib8/He7i4bzzXF891dtBrsOxAF4ejMWiEDXZPxaOhlCXG/340nNjaiH6YFiH1XXAPP5cUVVxaFMXeYfVQGbVFIF29ZwFnBfPrwsJoWBYrK25dWAK/lpgA2zZPfuPXx1cQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Nbs+IDNr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766685420; x=1767290220; i=w_armin@gmx.de;
	bh=SlTKS7S/P6wLUsnsBLPEZl39VLlpxmFf1Zt7tpFyAOY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nbs+IDNryPr+2C5LkpnDOtCCHwzEf0TPG1m6+/1Bb+WykQWAYo3Tn92roiMc9h6P
	 cJ+yXLh+mNKARfGa4+4r/u4dZgnBDiOb5SWd20g0h5L4UjlrQfNRwYEeO/Q7HAhPO
	 1IemcqvuMuWLIV4e0zLx+xhUkuiWCgxjKhTrria5Lgx9fh76zly4NQvpzmZTKrrAw
	 QI0xIh9DX9Vq75aUayzT5u5+fG6y8q+eFSR1sC4b8kfLD8Dae/sNV4l9+ag+6tWSs
	 hnAASD8RnD8A9haZz++PZ42Yfo5pqnTdOeH36/goisLC+6Q6BVPRiWcDOGouhTaGP
	 XJBcaY+NpOezgd70GQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([5.61.142.23]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1vRYQc1M0k-00StgT; Thu, 25
 Dec 2025 18:57:00 +0100
Message-ID: <c7384f13-e286-45a4-95c6-24d389217185@gmx.de>
Date: Thu, 25 Dec 2025 18:56:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] rust: WMI abstractions
To: Gladyshev Ilya <foxido@foxido.dev>, Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
References: <cover.1766331321.git.foxido@foxido.dev>
 <DF4Q36EVR4Y7.2MXOCNR87IPBF@kernel.org>
 <0983b1b3-f9b0-41b3-8cab-3d8ff2819e56@foxido.dev>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <0983b1b3-f9b0-41b3-8cab-3d8ff2819e56@foxido.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IE1ITGGpeVvT3Tb9E5U3V5Vce28zl1WLw24gZx1g15AS8yBB1Ze
 FTw3T55CvCw4ODQGdFAOZzGwgo+piHVqdjKK1FxqpZWqVmQViosVV+8lgoUBV31rDtRd5Xe
 hdZAXpRFPk1CFS6VE7Y+GNxuUlTRLdfu+E9uEGQzJiCSCGnq0aG7r/8Z9EwE3nlJUWdYYWo
 lc6E21O9KpLfhtVCRqGXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:35nby5Tz0Ks=;LpqjQig9ZSKKm0Kwob0hDIGWoR1
 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
 /u/zOg8eqHBmN2hPU=

Am 22.12.25 um 22:30 schrieb Gladyshev Ilya:

> On 12/22/25 14:52, Danilo Krummrich wrote:
>> On Sun Dec 21, 2025 at 7:22 PM CET, Gladyshev Ilya wrote:
>>> Overview
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>> This patchset was developed some time ago out of pure curiosity
>>> about the R4L project, but I believe it may still be useful, so
>>> I decided to resume and post this work.
>>> The goal of my curiosity is to develop a simple WMI driver in Rust
>>> for unsupported laptop (I have some laying around) or, as a last
>>> resort, submit a rewrite of redmi-wmi as a sample driver -- if that
>>> would be acceptable.
>>
>> It depends on the subsystem maintainer, please also see [1].
>>
>> [1] https://rust-for-linux.com/rust-reference-drivers
>
> Yes, I Cc'ed platform-drivers and WMI maintainer in a hope to gather=20
> their opinions.
>
I am OK with you using the redmi-wmi driver as a reference driver. TBH i a=
m very interested in having rust
abstractions for the WMI subsystem, however i currently have no clue about=
 the rust programing language itself :(
I plan to complete a rust tutorial in the future, but till then i can give=
 you only limited feedback.

>>> Why RFC?
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>> 1. No real users for now
>>
>> Above it does sound like you are working on a new WMI driver as well?
> Well, I am planning to, but I can't guarantee any success at this=20
> point) So "no real users" is honest answer for now
>
> But in a case if a) WMI subsystem is OK with reference drivers, and b)=
=20
> I fail to write a new driver, I will submit redmi-wmi-rs as a=20
> reference driver (since I can test it on my hardware).

Fine with me.

Thanks,
Armin Wolf


