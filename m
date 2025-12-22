Return-Path: <linux-acpi+bounces-19774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF8CCD5E1F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 12:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C003033DF7
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 11:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D232F753;
	Mon, 22 Dec 2025 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lner+4bS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE3314B75;
	Mon, 22 Dec 2025 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404369; cv=none; b=WGcD9pa4tYY4C0ODHvCd6Qy+5jARm0XduERhVgx2jdSQVYywioIcGowk6/MHqQ8TFSISKXxJF8Us6bi6eHqBvuoLWSdeTRX2qDina1B7Fs27NrD3ZvU+4tcfT8PfAp2KjdR3qPQRtuV9nlAUaQk9f4HTk78SKLglhXpBEIain24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404369; c=relaxed/simple;
	bh=E5NETcoDhL9pJRYrFiDVcpXbzdljWufgU4ePAeTn52k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=TKJDZ18Cb9UQytbTS14FccaoOl0t2AOLvDHgsv9WRxfOGn3j0kfEIKzWquBV7xnCgp04quGTTtKLM4iSPVkJPdfviIppy77ieVjcyVx7V55Awi0qwZFNvblB8f2IRMqD2phTmf/NHjoDG5rlSoVWIAMoiG6I1np67tdmsxSDty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lner+4bS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C123C4CEF1;
	Mon, 22 Dec 2025 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766404369;
	bh=E5NETcoDhL9pJRYrFiDVcpXbzdljWufgU4ePAeTn52k=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Lner+4bSByi2HDQGD6DtF5Amm64rTq4Tk2GJKUhqDh00W7X6e9w3TyJDFHKAdrswX
	 DXejKR5OD3WclegXD9JswqwLy2BsfzcVjVPO/HoJ+8yxivtyn0fkVpMEzn8iSmonXT
	 I86PEilVx8btf7L2sKZR4v/+Jh7Ajt50ervjEg9aaTfeh14cOw7yD438a2/2G+X4NZ
	 thnHHRh7VGpagz+n1lbRhtykkSTUx9nTO5dbkjfT2mD9W6stB9NXj2HW9Jf7Gr96qF
	 mzk5pjzpuEH+uuQGvqit8r/mhpGPDb3AhoZhJos/IEN+ehDtLiMaPxdln+yR/bIY5G
	 xfvrgFhcbpdEw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Dec 2025 12:52:44 +0100
Message-Id: <DF4Q36EVR4Y7.2MXOCNR87IPBF@kernel.org>
Subject: Re: [RFC PATCH 0/3] rust: WMI abstractions
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@gmail.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-acpi@vger.kernel.org>
To: "Gladyshev Ilya" <foxido@foxido.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1766331321.git.foxido@foxido.dev>
In-Reply-To: <cover.1766331321.git.foxido@foxido.dev>

On Sun Dec 21, 2025 at 7:22 PM CET, Gladyshev Ilya wrote:
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D
> This patchset was developed some time ago out of pure curiosity
> about the R4L project, but I believe it may still be useful, so
> I decided to resume and post this work.
> The goal of my curiosity is to develop a simple WMI driver in Rust
> for unsupported laptop (I have some laying around) or, as a last
> resort, submit a rewrite of redmi-wmi as a sample driver -- if that
> would be acceptable.

It depends on the subsystem maintainer, please also see [1].

[1] https://rust-for-linux.com/rust-reference-drivers

> Why RFC?
> =3D=3D=3D=3D=3D=3D=3D=3D
> 1. No real users for now

Above it does sound like you are working on a new WMI driver as well?

