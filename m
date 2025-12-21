Return-Path: <linux-acpi+bounces-19741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B840FCD4419
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 19:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 656F13007604
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 18:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FFC2882B6;
	Sun, 21 Dec 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="VmVEZ5ZQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="iOzyHQRh";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="rVHPQ41w";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="amZUeVHn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender8.mail.selcloud.ru (sender8.mail.selcloud.ru [5.8.75.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541382236F3;
	Sun, 21 Dec 2025 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766342541; cv=none; b=U7BI7VV44e83M+gkaIUfzT1pVk+z4oBucZvMEIm3bG8bJoE5Ah4MlDVidxAkQHqxXvL6ppb99WXB9zokjn4J/gJY8f/VIAEU/o8UXbsyAIVGnnJBysqa8oPZsGoPPlziSBw7rSd4PSpvDfFeeLHlrr1xoVBzk6lP65tUauPHVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766342541; c=relaxed/simple;
	bh=ewDXJ92nqmjmgcRy6bbFHt6exby2eLI8vrpfQTvr/xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNlfk2mP41IW+g8rV3nJ7NewrQcsn+vBwyKnDKaEIrOpsea+vned6GA0e+p14rFDlhD0LHol12rtq02xqH8g4tSpBH7om8ydcODa74WKM9A4EqIAKMDPvgLPwZl/qkC3Rk7ttzD5qhU6SCDcltG8+TPn6k2D+IUietHfvPbZMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=VmVEZ5ZQ; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=iOzyHQRh; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=rVHPQ41w; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=amZUeVHn; arc=none smtp.client-ip=5.8.75.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KNqbE56JeVxXH6bY9brDdpiS0n3wvdlFojRJ3E6dFEk=; t=1766342537; x=1766515337;
	 b=VmVEZ5ZQAPy0S5tfm4YExdPAZGbGZFmh7xiNcvTYmcmhrxYjzyf6V+Vbfh0y92Dz9Na9KyeGcn
	sApub5Ov6SWZ6Nhrg/Tx77I7+9ABpuCeHHAaReEdjUavZcXypkK+DYg2nYuX8oCaLrlzdqqc3y/u9
	AtdMOYTe2tOBxl/sdCG8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Help:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=KNqbE56JeVxXH6bY9brDdpiS0n3wvdlFojRJ3E6dFEk=;
	t=1766342537; x=1766515337; b=iOzyHQRhN1B3V1pR22o7r/MgPh5uaSMLUbAQW9O3HEWwidB
	epQkouOuLjNk1BPJwsFd3KXHWlBZ4GYc3mFQX8yCuzUBeOv7M4egnAgI9u0oDMQJExTQduxnIYiLY
	qC9TuCD6BlJig1A4dRtnwpdTBWGHtr2/1LYxqWPtPXSm9gQ=;
Precedence: bulk
X-Issuen: 1502087
X-User: 335779833
X-Postmaster-Msgtype: 3849
Feedback-ID: 1502087:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251205.071128
X-SMTPUID: mlgnr62
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1766341429; bh=KNqbE56JeVxXH6bY9brDdpi
	S0n3wvdlFojRJ3E6dFEk=; b=rVHPQ41wFWeobOoswjfbReSUG5gWqf5joA6iHSNqRSeyq0hKfa
	px2d4RM4/6V+gS3VwqyGkGPSGO7frJfIf6kEgo7iuo6CW9VZlrj13oVgP4q7Vy81sIKSumi+GjK
	ULgPH2CDsvT3ysFS6Xnut/pQ1ZD5r2wnfasNCobxOcFRUc+NObHKaNS6mJbMhMqukZeRUgvIliP
	iS2YfauZtaUVzhEmhJWcEWP09wP9zdemfnMWuwIztsps6XlaCe99KUnf0fkFAN9XoY1Gmj+M6of
	tMa/gMLlhihEeeYMQLijvQZIJKbMNX5vcboJDDlOkW4ztBb+/ULqE7Q4JUg944qkmbw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1766341429; bh=KNqbE56JeVxXH6bY9brDdpi
	S0n3wvdlFojRJ3E6dFEk=; b=amZUeVHnl30rQj8yN5k5Dxx6/8SzoOQzRxRfxZBYkgLnQ+d2BI
	kEuwAm2obeU3BA5pUtADx+j4GSq5GwvdVRCQ==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Gladyshev Ilya <foxido@foxido.dev>
Subject: [RFC PATCH 0/3] rust: WMI abstractions
Date: Sun, 21 Dec 2025 21:22:36 +0300
Message-ID: <cover.1766331321.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overview
========
This patchset was developed some time ago out of pure curiosity
about the R4L project, but I believe it may still be useful, so
I decided to resume and post this work.
The goal of my curiosity is to develop a simple WMI driver in Rust
for unsupported laptop (I have some laying around) or, as a last
resort, submit a rewrite of redmi-wmi as a sample driver -- if that
would be acceptable.

I know that there is an undergoing API change in the WMI subsystem[1],
however it doesn't change the abstracted surface a lot.

This patchset consists of 3 patches:
1. Wrapper around ACPI objects (this may be unneeded after [1])
2. WMI abstractions
3. Sample driver for demonstration purposes only

Why RFC?
========
1. No real users for now
2. I have a feeling that I am doing something very wrong

[1]: https://lore.kernel.org/platform-driver-x86/20251220204622.3541-1-W_Armin@gmx.de/

Gladyshev Ilya (3):
  rust: implement wrapper for acpi_object
  rust: introduce WMI abstractions
  rust: sample driver for WMI demonstrations

 drivers/platform/x86/Makefile        |   1 +
 drivers/platform/x86/redmi_wmi_rs.rs |  60 ++++++
 rust/bindings/bindings_helper.h      |   1 +
 rust/kernel/acpi.rs                  | 103 +++++++++++
 rust/kernel/lib.rs                   |   2 +
 rust/kernel/wmi.rs                   | 267 +++++++++++++++++++++++++++
 6 files changed, 434 insertions(+)
 create mode 100644 drivers/platform/x86/redmi_wmi_rs.rs
 create mode 100644 rust/kernel/wmi.rs


base-commit: 9094662f6707d1d4b53d18baba459604e8bb0783
-- 
2.51.1.dirty


