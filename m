Return-Path: <linux-acpi+bounces-20020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA1D0007D
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 21:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94B363070FF4
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 20:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3C1337BAC;
	Wed,  7 Jan 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="mq2/HCly";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="SE/PBt6G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387C250BEC;
	Wed,  7 Jan 2026 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818200; cv=none; b=DlazNWs/lxpSX6r4pn9utBj9j+8bImCayQt+prOpIAsW89oV/8XMBKNUFl22bN+ayMCHjPSlfFA8zRcyQojD3NSAL/AfinT+bjyWXf4Mwz22XJFvmN05KozVzZHoHpMvoUESFat98sx58iJm7oL8ZW+1LEGkPiUYxMiR5YbTPes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818200; c=relaxed/simple;
	bh=WBVRE7FenPXjVK9OidcHszubXml+J+NEwIPajV4isng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWorENv0sLbQZS3lRENfTs/cfKVyDgihwntZEmiTpTaNdhRSLSMO2jXHv48LaZ6Xp0bSQM7Oz7aDGCfkiPtL7MFgqU11zZYi+bc5bC/LBTBpu3LoiF56vQF996ICNaNxLnLqQ7TnxDCCpN4HW6/KtuRe0YLfomSV7th614nf/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=mq2/HCly; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=SE/PBt6G; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767818172; bh=YFeNaRFzdobaziW018sXto4
	xCCUOKZrx0W+D4kBigmI=; b=mq2/HClyuWQIevRcF2lvZDuXkK0WZCNsDeo5Emifu8E1ZtAWdv
	1vJ1Gho55YwTn8BQiqhBsJX3qWRdZJr0SuCZ0MbjiKjN+wtGCj8oZ/rKUigBb8tdLk8Hoyt6HrJ
	HNxzJUjKXc5EW4AnRzObQ55mEhg0PGDQsqwQ0jQhTuQyGLVUpgtQmBlBHgdcwPF+IApdqBzix06
	PgyivbxJIMTDxzuOIWeU7l40ZqyJr8CrKcKFRQ39CTbgAqsKrCQaJcD1ItApvx5cD+3OjUxS+cP
	m5bbuvExspCTqtDc5sLlf+DER3zEREeHAIZyKrl3ifPDfX+KgGPBu5LnvA8c7NKtVnA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767818172; bh=YFeNaRFzdobaziW018sXto4
	xCCUOKZrx0W+D4kBigmI=; b=SE/PBt6GZuMax8DuGFjtI5ir3b0cI9ETa+36jy2FlAQXsp+NMX
	R17EZ/8RkUd575XpicZUJRHHHGqwArzWNZDw==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
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
Subject: [PATCH 0/3] rust: WMI abstractions
Date: Wed,  7 Jan 2026 23:35:30 +0300
Message-ID: <cover.1767818037.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overview
========
This patchset implements WMI abstractions for Rust drivers. It is the successor
of the previous RFC posting [0]. These abstractions allow most WMI drivers to be
implemented in Rust (provided other dependencies are abstracted as well).

Currently, the only driver in existence is a stripped-down rewrite of redmi-wmi
that can probe itself with custom data and print messages on notification
(posted in [0]).

I am currently working on wrapping redmi-wmi's other dependencies (sparse-keyboard),
so I can provide it as a reference driver (Armin is OK with that [1]).

Notes
=====
I do not know how these abstractions should be handled in MAINTAINERS, so for now I have
simply added them to the original WMI entry. I would be happy to be added as a reviewer
to keep the Rust version 'synced'/valid though.

[0]: https://lore.kernel.org/rust-for-linux/cover.1766331321.git.foxido@foxido.dev/
[1]: https://lore.kernel.org/rust-for-linux/c7384f13-e286-45a4-95c6-24d389217185@gmx.de/

Gladyshev Ilya (3):
  rust: enable const_intrinsic_copy feature
  rust: implement wrapper for acpi_object
  rust: add WMI abstractions

 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/acpi.rs             |  91 +++++++++++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/wmi.rs              | 277 ++++++++++++++++++++++++++++++++
 5 files changed, 373 insertions(+)
 create mode 100644 rust/kernel/wmi.rs


base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
-- 
2.52.0


