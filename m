Return-Path: <linux-acpi+bounces-19791-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D09CD7611
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 23:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 851133007ED1
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5599933EB17;
	Mon, 22 Dec 2025 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDTuYVCt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A21033E36B;
	Mon, 22 Dec 2025 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766443491; cv=none; b=H7wbJTLeSLM8w9X4wWtbbvUrCVWQviqJLNC99RcEm8PFKMQ3g7W4insozvZ1v88ytltn4F9gIl0Lx0y5+e4BETZNAM1MNCGA18pGtQtKguIayK+oZ57TecRce8aFI25bUlaJakgRYd+XQ5DOleAqPYqb5fXsdQ5Yb+/0BcEBeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766443491; c=relaxed/simple;
	bh=TUCyA3EC02TvaUugoS44x2r6rqCoKDDtUUFU7OnlwOM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eZwMfUpo2rIzjkSofPQL6dUyUXD2ggzIWMHQ7Zvltilxt2LMpmTeLTCLxV9AkqNx3C5pyN1A7FJVUbjLjWTR5gFbT+wWj69CFTJHyjVKhbdvPlhljBBaxVOyZxtQd6q3t7AF2DSWCnKQhsch+h/MFY+IlJUSqCylhGO0GEEr6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDTuYVCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDBDC4CEF1;
	Mon, 22 Dec 2025 22:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766443490;
	bh=TUCyA3EC02TvaUugoS44x2r6rqCoKDDtUUFU7OnlwOM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hDTuYVCtrNn7IhuTo6qJfP140jkidhiadq+kg2N/tHHohTamuY6TMmQ8q4yKkj0pB
	 fhjiNvSYvrIYQRaWR2pSIRSRMBM3eTw6PihsCkjyC42eoVaCKIQIhwLu4jMhIvOQq8
	 BmKFFmmtCYdqNuyU/TDu7JyCPXkj0zOz/L5QXcZ/TsbTtBxafqcmWpQQALxvqZovMH
	 Lt7BYhxOgT5dQem1R7WBfDBrskSlEbe5vKx6PXawiyNsHSDSgsfqrtHBJBLxtO/2H9
	 McKH1/2/Bo6YycGKdngW5wI1TAOzeYISVopHXI2wzYWSSU7gXzcQQFtmRDOjyOeJqd
	 fQHwt4joAN6BA==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Dec 2025 23:44:45 +0100
Message-Id: <DF53YEJYNNBD.1W5RQEVY41RLP@kernel.org>
Subject: Re: [RFC PATCH 1/3] rust: implement wrapper for acpi_object
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
 <a28e83201e1413091333509628274807e50ec170.1766331321.git.foxido@foxido.dev>
 <DF4PPPGQBPNA.13TJNSRSRUW0A@kernel.org>
 <4266e3d2-141e-44bd-a4c1-b140674542e3@foxido.dev>
In-Reply-To: <4266e3d2-141e-44bd-a4c1-b140674542e3@foxido.dev>

On Mon Dec 22, 2025 at 10:47 PM CET, Gladyshev Ilya wrote:
> I couldn't really decide between implementing all types or only the one=
=20
> needed... Probably, I should provide simple implementations for all the=
=20
> others, I will fix that.

If they are not needed by any of the drivers you're aiming at, you should
probably just drop them.

> Wouldn't it be confusing to overload Deref on a non "pointer-like" type=
=20
> just for an implicit cast?

What do you mean with overload Deref? What I mean is

	impl Deref for AcpiBuffer {
		type Target =3D [u8];

		[...]
	}

	impl Deref for AcpiInteger {
		type Target =3D u64;

		[...]
	}

	impl Deref for AcpiString {
		type Target =3D CStr;

		[...]
	}

etc.

