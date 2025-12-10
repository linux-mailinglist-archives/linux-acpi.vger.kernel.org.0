Return-Path: <linux-acpi+bounces-19537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDECB3340
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C416E30A085E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02BB31E0EA;
	Wed, 10 Dec 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoV9232a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7534F231830;
	Wed, 10 Dec 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377897; cv=none; b=fVQA4DQWmqKTSf6H1Y1WA54nhRgiGe5K4HoHJIpkl3XhE4UPK9CfNKUN23BVVfdPFHYGYqhtGmurh7DVwSNZJ0gFQVMAGl2DzVhni37CDW+7WXn6huBA9wR5pcoBSLs46H7pgZdwvHPHYOc/kPAojL3yjPT2adHVuzrfpmBHCzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377897; c=relaxed/simple;
	bh=uiFDwdd3+DGr0jw2UwQPL1npkz2+APjFCpmsmDeJ1vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZaJwCEzslz1kUF9rGHAD20MvzKmHSQ4Um8Sll7MYWAafnYixKYdTb0meQXrmqecd7lDOXAYD1HBFaO0Kp5fqyMXgpb0F+jwVJTwaJn5KtoPZvj4qruBp0eXj9lIJgSB9QZoKGFTRS1BOGKqRPiQVApWdHFJEUgBDkgwKwIyZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoV9232a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172D1C4CEF7;
	Wed, 10 Dec 2025 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377897;
	bh=uiFDwdd3+DGr0jw2UwQPL1npkz2+APjFCpmsmDeJ1vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoV9232aHs/pqmqp84LJyeiHXrFQufyFFrlCr33Pg3N+9L9ZdmYAZP58+/Aw8i9Ga
	 QyUAhvEAaAgBtrDWwZsGdQZIxiyg86otdf59HjbC4T7q2Awrco/oWYR9qD/McxW3nV
	 d8X50i/NJ0PwlunFUeCt/ZVd3rkOQd0ylb0/JHndvFj7fdRho5E96cIPAogjUZNRnu
	 IPQeKRzHNi9Vxmv1hV7gK799qzEhsqEWJwpKWXuFMwZ2IXRIQ5UFWlBR8lzmA7NNYE
	 o875yfF+t7wX5Vaw17vG2ys6BbCeJunT4eFRUWhobXDoMDe5Xe8SiYt5dX/hSfvtFL
	 unixkzwDBBUOg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 1/4] ACPI: scan: Register platform devices for thermal zones
Date: Wed, 10 Dec 2025 15:42:21 +0100
Message-ID: <4701463.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
References: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, platform devices are not registered for ACPI thermal zones
because they are not represented as device objects in the ACPI namespace.
Instead, they are represented as thermal zone objects, so in particular
the platform_id flag is not set for them during enumeration because it
is only set for objects of type ACPI_BUS_TYPE_DEVICE, but otherwise they
are handled similarly at the ACPI core level.

To facilitate converting the ACPI thermal zone driver into a platform
one, modify acpi_set_pnp_ids() to set the platform_id flag for thermal
zones in analogy with device objects to cause platform devices to be
registered for them.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1468,6 +1468,7 @@ static void acpi_set_pnp_ids(acpi_handle
 		break;
 	case ACPI_BUS_TYPE_THERMAL:
 		acpi_add_id(pnp, ACPI_THERMAL_HID);
+		pnp->type.platform_id = 1;
 		break;
 	case ACPI_BUS_TYPE_POWER_BUTTON:
 		acpi_add_id(pnp, ACPI_BUTTON_HID_POWERF);




