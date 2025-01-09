Return-Path: <linux-acpi+bounces-10493-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F1A080AF
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 20:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166AE188BEC7
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFF91B0402;
	Thu,  9 Jan 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1AGDMq+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3984039;
	Thu,  9 Jan 2025 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736451747; cv=none; b=YP2dIE650r3pEhwdoxPBhl/4mJ6KUh67rWViNyn0FCRafA+R9FRYGEO/et7qIFSyjSYIqe33190sUGp4lMzqWKcZVyj1NSJka1u096F0cOATPPFUPK9o5qf8cIKJ6q36KQXu6PbYm1tmNCN4me7vTRDQ8QLT6qFRPrp4p1xKkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736451747; c=relaxed/simple;
	bh=XtUl7FPNqYDK8EwQIxQ9yB0/v394mKPMwRsJLf2eJlY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AXl+M1VK18POPyIIYAkurayVWWE7SmYMo8fzOzCarf6BhgzIPhX0huhZV8G1ytgxgYTIU8SM+0lZpqM3aLF82Ei273KBvGj4hXfD0nNJnV94AKdPursLm0qWzpCoF7XfocBWXfGUtvF2qU/j+/NxCsrcvHBseJAjNWLcP63qY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1AGDMq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F6AC4CED2;
	Thu,  9 Jan 2025 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736451745;
	bh=XtUl7FPNqYDK8EwQIxQ9yB0/v394mKPMwRsJLf2eJlY=;
	h=From:Subject:Date:To:Cc:From;
	b=Q1AGDMq+jGdMGqBI2AK6Q5DwxRAQQQtn3etn7SovkxmlJqo7gZCwT+Rlhw9xzUQ5l
	 S8BLV61MmubE1krYmi95FS4NcrPK8cSqYUztRfcjcqmnoHy/SAnEbpsYrAjN04lPB0
	 j5mkoC86kQQsiMvO0Gmb+N+iQom7iESyj/EhgpQr9gGfzR/MdmklHtRRvk0etjlAbv
	 V0/2bEclx7XjGZHwiiK0uYJj+BHJWG007bc6zFOnvrkxx077PXCfrp8C1cQaW5gxBm
	 Nm7UwXkhfHVfrgGyvL04NHLDNSLIQzojU5YK6W3JLeO6ti6HfrfibYER2iBzIb3mBM
	 1+Pqk+6VAo5ZA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/2] device property: Warn on
 (of|fwnode|device)_property_read_bool() for non-boolean properties
Date: Thu, 09 Jan 2025 13:42:04 -0600
Message-Id: <20250109-dt-type-warnings-v1-0-0150e32e716c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIwmgGcC/x3MPQqAMAxA4atIZgO1IFKvIg6tjTVLlUT8Qby7x
 fEb3ntASZgU+uoBoYOV11zQ1BVMi8+JkGMxWGNb0xiHccf93ghPL5lzUqSZWhtd14VgoWSb0Mz
 XvxzG9/0A1AiqbWIAAAA=
X-Change-ID: 20250109-dt-type-warnings-efe52d977bb2
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

This series makes using (of|fwnode|device)_property_read_bool() on 
non-boolean properties give a warning when used with DT. This has been 
deprecated behavior for a while now. Soon we will add yet another 
variant of this function with a Rust binding[1].

Why not put the warning in the fwnode code? The fwnode code doesn't know 
the property's type as that depends on the firmware. For DT, a boolean 
is a property with no value.

Perhaps the ACPI backend should have a warning too? I looked briefly at 
it, but I don't have a clue how or if that can be detected. Doesn't look 
like there's a specific type for booleans. In any case, that would be an 
additional change on top of this series.

[1] https://lore.kernel.org/all/20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org/

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (2):
      device property: Split property reading bool and presence test ops
      of: Warn when of_property_read_bool() is used on non-boolean properties

 drivers/acpi/property.c  |  1 +
 drivers/base/property.c  | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/base/swnode.c    |  1 +
 drivers/of/property.c    | 33 +++++++++++++++++++++++++++++++++
 include/linux/fwnode.h   |  3 +++
 include/linux/of.h       | 29 ++++++++++-------------------
 include/linux/property.h | 15 +++------------
 7 files changed, 89 insertions(+), 31 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20250109-dt-type-warnings-efe52d977bb2

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


