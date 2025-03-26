Return-Path: <linux-acpi+bounces-12441-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DAAA71CC7
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B537A7742
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A3B1F8690;
	Wed, 26 Mar 2025 17:14:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E751AF0A4;
	Wed, 26 Mar 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009281; cv=none; b=sRSkAkdS6A1VVeU+gdjUORnW7Jlgp/+Km0MmmleM1Dv0kJncQU7SL0ckLScXY9kS2XXzP57TFoi3UjiErdAMWPE3EZlfka9CSvBY7lNb7FjImoQyGulearBXRYqqC0rIm+OPOdpd4HAri5bzXcVXGtnxPGUH5j/dG+yFrK8850s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009281; c=relaxed/simple;
	bh=VV5D+WSU9wDTGuyDpTjMKcWhEaqgJqPcE2h83K4BxYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L0ISspx4RjvWBsVxP5XH6utVFOlzgjuGMDRCUtJqhxfafaGl2hEugx8ozin+yD1zrSsPAmHIqCtTHLej80s5yXprW8ovYJpm4gc0Zvq8fHwshJ8Vo0cuD8DUVMoghBhIqjr+8ItcwKjMeFdC+lJDpPOGiPk35AlQEkoLhKVMyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZND1119Zpz9thy;
	Wed, 26 Mar 2025 18:14:29 +0100 (CET)
From: Remo Senekowitsch <remo@buenzli.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Rob Herring <robh@kernel.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Remo Senekowitsch <remo@buenzli.dev>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 0/10] More Rust bindings for device property reads
Date: Wed, 26 Mar 2025 18:13:39 +0100
Message-ID: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZND1119Zpz9thy

More Rust bindings for device property reads

This adds more Rust bindings for reading device properties, based on
Rob Herring's work. I'm working on a driver[1] that uses these, but the
driver has more dependencies than this.

Rob Herring and Dirk Behme did several review iterations over on Zulip
already[1], I'm thankful for their great input.

This is my first time posting to the mailing list, please let me know if
I did anything wrong.

Remo

[1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/DS90UB954.20driver.20done.2C.20ready.20to.20upstream.3F/with/507874342


