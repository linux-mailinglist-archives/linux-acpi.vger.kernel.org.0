Return-Path: <linux-acpi+bounces-14151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA4ACF216
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98C4169AAD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 14:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2156119CC27;
	Thu,  5 Jun 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzaUGgkx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B01198E91;
	Thu,  5 Jun 2025 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134069; cv=none; b=CpokhdjyxM7naLd/uq1sYdEYtz2Ss2DsKFGxB2W4iG9ivui8Co3WQzq8MQyJGblrdRlLzLJtKltxqIFne9Uj78lxRNNegYTgpOiaNn+VlYdIl0jAWx7hFxRaM9esgL66KzWXJ5zUJP0vTifAbBMRYcgupasaWmR6IlbMDrpj+NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134069; c=relaxed/simple;
	bh=bizip3kwAB8W3CkUozAAw1K0artPGLYH9/tZAn3jPFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVx4fukMJxWcqi0yrOZ/+nXm50OgHLUcUrEQ0HRO7L/5C/QhXQmEs/76uafey2ibCgZbfuyTst6RVgv/klu1gn7af+260vx9WQGPU39UyVpJ3q1QVZ++6MjsuymiDNuYQHmnG/8cvhdY2FN18qeX1tAxys5AUvethWaUsuygbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzaUGgkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60DAC4CEE7;
	Thu,  5 Jun 2025 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749134068;
	bh=bizip3kwAB8W3CkUozAAw1K0artPGLYH9/tZAn3jPFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzaUGgkxpwyq0iXmltUFBoaJF5gKx5fRQqw6VBXHJmHMr7647kbYYIzMr0zqHYA5F
	 9XuiG14zr4AG3FOoVMQnWK5QnUXOwSmJP4Z+G0RHKxs1AnUTSZW0OAqyhIVt+92HPm
	 41uGoXfabjdc4wDsGNmUzm+uscIu1bG3Ho2zoCVwFo/a5/NuE6aX0iK039fV0FDyJI
	 c4qC4R+11e1RlgkDs+yfj0bwqR4h2AkseTUm0VrfIhPKscs7hzTcBP8zoMnPuqu9Tk
	 YLbnj7TxqWPlAqGh9yRoh8fzF9prohAfRz9GgnWysqMZ3JFQ3NfFSusgLv5N8EHX53
	 hDdPmOTLVCXkQ==
Date: Thu, 5 Jun 2025 16:34:21 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin@yahoo.com>
Cc: Igor Korotin <igor.korotin.linux@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>
Subject: Re: [PATCH v1 0/5] rust: Add ACPI match table support for Rust
 drivers
Message-ID: <aEGq7a6fVUoCPeAl@pollux>
References: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
 <aEC73CHD0fvByrJs@cassiopeiae>
 <2d02be52-b22b-4a2b-bfbe-aff7b62200e8@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d02be52-b22b-4a2b-bfbe-aff7b62200e8@yahoo.com>

On Thu, Jun 05, 2025 at 02:57:21PM +0100, Igor Korotin wrote:
> Should I resend the whole series as PATCH v2 with a changelog?

Yes, please do so.

