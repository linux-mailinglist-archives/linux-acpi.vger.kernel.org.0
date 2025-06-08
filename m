Return-Path: <linux-acpi+bounces-14217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA7AD117F
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAB6188BFB6
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Jun 2025 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACC1F0992;
	Sun,  8 Jun 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQjIx3t+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6172713C3CD;
	Sun,  8 Jun 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749368887; cv=none; b=uF0TD2kug1vk0yjb92JU+dsieogjk+XFC9mQi5xZbmx5TAau0ScNg3aNan82SjWZxrHgl/dbfAuWAkp3V2AMQqD7bBAXqAvpyNyNnlYhTtLw3bq/l+W86gZ639Ub7ySshdsoXILM0RY3iofRFp6ZdTkjRWKnqixL2FSw6vZWQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749368887; c=relaxed/simple;
	bh=tM0oOS9dnX2Vm7tlGZiHwOnO7xNgAeQDpdXG5G/CX2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Re1JO+DDaFcia628+Ok50NR4YH2E/VLrdB4OCpDgixX05dAn2c9rnOIvFvCplmMGYygSMGb9RvW6Ba28u32R2cZFBthrVYJYZKMhpZwnCUGb5wmtO5Abynr2kcvJefaHx4MPqtVnA0UOJbJApbBGbb0BdrT2Q9kQO9CSzZ9cC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQjIx3t+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB51CC4CEEE;
	Sun,  8 Jun 2025 07:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749368886;
	bh=tM0oOS9dnX2Vm7tlGZiHwOnO7xNgAeQDpdXG5G/CX2Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eQjIx3t+KYMrCoq5Hz9vypRHXYoAm/k1QHzKcdfEWKRWaWLLNaEcWak9ms08d69Y4
	 zh/NaJZs9q7zaSOkChwInR6i20o1LkXI7cdCt9lbN09xmgnhxYs8AI/uDI6MnXY4LQ
	 C9V4IRG3zLBDf+UMZP+mAOgvP4hfNqwt0Jh588Zy82hpS4mK+XaP/65bsh1KbPELpx
	 lyTrbY1TATkiDQ0uJhxYFRBz9SD5njDpQue9cL6vsX/B7U3rhbJQiKYuEbs+5vFGoC
	 h5amQaPzH/3dA/KDqdG/lIyl6bRx9RJwOut+7N48bAjk9DbjaOxgSr8NpNHx7X15Go
	 +maZf2ZacNT1g==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Jun 2025 09:48:00 +0200
Message-Id: <DAGZIHBVBI6Z.32401TQB5MNTL@kernel.org>
Cc: <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <benno.lossin@proton.me>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <lenb@kernel.org>,
 <wedsonaf@gmail.com>, <viresh.kumar@linaro.org>, <alex.hung@amd.com>,
 <dingxiangfei2009@gmail.com>
Subject: Re: [PATCH v3 1/4] rust: acpi: add `acpi::DeviceId` abstraction
From: "Benno Lossin" <lossin@kernel.org>
To: "Igor Korotin" <igor.korotin.linux@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170641.3881401-1-igor.korotin.linux@gmail.com>
In-Reply-To: <20250606170641.3881401-1-igor.korotin.linux@gmail.com>

On Fri Jun 6, 2025 at 7:06 PM CEST, Igor Korotin wrote:
> +impl DeviceId {
> +    const ACPI_ID_LEN: usize =3D 16;
> +
> +    /// Create a new device id from an ACPI 'id' string.
> +    pub const fn new(id: &'static CStr) -> Self {
> +        assert!(id.len() <=3D Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
> +        let src =3D id.as_bytes_with_nul();
> +        // Replace with `bindings::acpi_device_id::default()` once stabi=
lized for `const`.
> +        // SAFETY: FFI type is valid to be zero-initialized.
> +        let mut acpi: bindings::acpi_device_id =3D unsafe { core::mem::z=
eroed() };

This can be made safe using this series:

    https://lore.kernel.org/all/20250523145125.523275-1-lossin@kernel.org

---
Cheers,
Benno

> +        let mut i =3D 0;
> +        while i < src.len() {
> +            acpi.id[i] =3D src[i];
> +            i +=3D 1;
> +        }
> +
> +        Self(acpi)
> +    }
> +}

