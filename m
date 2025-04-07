Return-Path: <linux-acpi+bounces-12833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A949A7F068
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 00:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F02A18959DF
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D43C224AF8;
	Mon,  7 Apr 2025 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WuMIXXzp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B122A4E8
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744065454; cv=none; b=sywL7JVQyyc7jCFqDpJp6tgxWgSvlSPpaV35ZJsLb1BbWuBPdoPH+kbkQru4VqO7zUGJIL9h0WiSHvRZ64GeVUvBskeX70AJ3Tqnv5hEOSINUNnyJp9xxwp6rHSIOYloOAsvECP8KOCsOJek7fxc0GB8om1LB3C0QsCHB8vNK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744065454; c=relaxed/simple;
	bh=g3kM2sk7bhM7/LZ5IEtcQj2u79TaXkp2NNHs8yaghh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nMD5OYp7Qqwf5Vk/fctMa7dd2bpedV7bEMEtSg6yniP8+JipCTjblLaOuDXW9PlkQ3aXeFOLVKK5w/WqzT9AE3ApxxNkJUbgpf4JU87v9Sr3lissHjuyiKrqrIRBqMyzGJSm9OS4C+wtpjQNjsYPOLZoGVnyYOGan2Bz+SkIdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WuMIXXzp; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744065440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WbBi/k1LpyYTmKsMc4bd6oqOgSUW7H+lQhYQZOWo1UY=;
	b=WuMIXXzp6/g2+o0+VUlNdmJx6a6lLtFCWSyq1co3Y1h6KZQNBMFfDpUrIxkw7RHClHxMqQ
	CcAhk/vOayRmjiLYFcSwqRfVpOZQNUghn1MjCYGXHolsRBLdori2kif7mHEe2+h0ztEoUZ
	ytyRdvAWdaYLSWs7Eonl6I4XmnxEVY4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	linux-acpi@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/2] device property: Add fwnode_property_get_reference_optional_args
Date: Mon,  7 Apr 2025 18:37:12 -0400
Message-Id: <20250407223714.2287202-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds a fwnode-equivalent to of_parse_phandle_with_optional_args.


Sean Anderson (2):
  device property: Add optional nargs_prop for get_reference_args
  device property: Add fwnode_property_get_reference_optional_args

 drivers/base/property.c  | 50 ++++++++++++++++++++++++++++++++++++++--
 drivers/base/swnode.c    | 13 +++++++----
 drivers/of/property.c    | 10 +++-----
 include/linux/fwnode.h   |  2 +-
 include/linux/property.h |  4 ++++
 5 files changed, 65 insertions(+), 14 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


