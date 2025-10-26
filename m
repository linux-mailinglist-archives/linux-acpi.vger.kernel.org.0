Return-Path: <linux-acpi+bounces-18231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFCFC0AAE2
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 15:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBAEE4E86B4
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Oct 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691282609D6;
	Sun, 26 Oct 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViWXUN1s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F321255B;
	Sun, 26 Oct 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490201; cv=none; b=nMdccdx5UTWqs7l4PXTps+3wcSeyKBCUGa/Mlfu2rLEDlBbWBFH39rFnK2c0S2z30gXW7xot3OmmOpJe4ffEgLf8v3tAoen4U8Fv5IeXsKL6hzwvQOe07464xWmcQINzuDPYXAsLA70dgvJ1boJOgxPAC65otmcVVUs7F/lA754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490201; c=relaxed/simple;
	bh=Y8eFOKVwrygZGMfhV/zhA56zGaYXAAazNY4E97Vs81M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n7YWPmCgoKcGO1ZAJRyNw+vnYbjvmfjPEXoYLcC7XkfYKBhykwNDA3wmz5CsOaIO8jeFI7braCd2AqVn/YesZ9f4W4NqdCbJCgUDXEKAiGRkJdIIDxcUpORo5O5pVp9RO+UIC+cn1+CfKhfCMyESxxgoFwmXdYr4m9ham3s2KpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViWXUN1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A61C4CEE7;
	Sun, 26 Oct 2025 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761490200;
	bh=Y8eFOKVwrygZGMfhV/zhA56zGaYXAAazNY4E97Vs81M=;
	h=From:To:Cc:Subject:Date:From;
	b=ViWXUN1szqaqLO/cYSoRVVBsIbssIW+iec8/w/kCQ1vgI/JKsN1sVHy5NVP0fjXGz
	 HGQVq1yQgAVilulmGJpN0JZZyHPB09wyDvF5Dy88xcpJpKSKuGSpYV323w1BYOTIZx
	 dxXirRAZZ/sKXYtaxz3UgPguSrW4lKyBEZZlyEXHktrZSgjyA2T4WNcUTbPVcuSpc1
	 RsVTTFju9i3QSDxtAF0Ws8Lz0G+Ir2zdI+/Sz4xQNHppoBYjiEY6kgh/B+PWrLV0ZA
	 nsGSjbMJRh/jTAH0PP9VL6yAim2Gyw5maWkX/2P7Goyokf1YJESyeWicSWbldtuhXr
	 nqDWUDAlKJEzA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] ACPI: property: Return present device nodes only on fwnode interface
Date: Sun, 26 Oct 2025 10:48:39 -0400
Message-ID: <20251026144958.26750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit d9f866b2bb3eec38b3734f1fed325ec7c55ccdfa ]

fwnode_graph_get_next_subnode() may return fwnode backed by ACPI
device nodes and there has been no check these devices are present
in the system, unlike there has been on fwnode OF backend.

In order to provide consistent behaviour towards callers,
add a check for device presence by introducing
a new function acpi_get_next_present_subnode(), used as the
get_next_child_node() fwnode operation that also checks device
node presence.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20251001102636.1272722-2-sakari.ailus@linux.intel.com
[ rjw: Kerneldoc comment and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – this change fixes a real behavioural bug in the ACPI fwnode
backend and should go to stable.

- `drivers/acpi/property.c:1375` adds `acpi_get_next_present_subnode()`
  so `.get_next_child_node` skips ACPI child devices whose `_STA` says
  they are absent (`acpi_device_is_present()`), while still returning
  data subnodes unchanged.
- The new helper is now wired into the ACPI fwnode ops
  (`drivers/acpi/property.c:1731`), making generic helpers such as
  `fwnode_get_next_child_node()` and macros like
  `fwnode_for_each_child_node` (`include/linux/property.h:167`) behave
  the same as the OF backend, which already filtered unavailable
  children via `of_get_next_available_child()`
  (`drivers/of/property.c:1070`).
- Several core helpers assume disabled endpoints never surface: e.g.
  `fwnode_graph_get_endpoint_by_id()` in `drivers/base/property.c:1286`
  promises to hide endpoints on disabled devices, and higher layers such
  as `v4l2_fwnode_reference_get_int_prop()`
  (`drivers/media/v4l2-core/v4l2-fwnode.c:1064`) iterate child nodes
  without rechecking availability. On ACPI systems today they still see
  powered-off devices, leading to asynchronous notifiers that wait
  forever for hardware that can’t appear, or to bogus graph
  enumerations. This patch closes that gap.

Risk is low: it only suppresses ACPI device nodes already known to be
absent, aligns behaviour with DT userspace expectations, and leaves data
nodes untouched. No extra dependencies are required, so the fix is self-
contained and appropriate for stable backporting. Suggest running
existing ACPI graph users (media/typec drivers) after backport to
confirm no regressions.

 drivers/acpi/property.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index c086786fe84cb..d74678f0ba4af 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1357,6 +1357,28 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+/*
+ * acpi_get_next_present_subnode - Return the next present child node handle
+ * @fwnode: Firmware node to find the next child node for.
+ * @child: Handle to one of the device's child nodes or a null handle.
+ *
+ * Like acpi_get_next_subnode(), but the device nodes returned by
+ * acpi_get_next_present_subnode() are guaranteed to be present.
+ *
+ * Returns: The fwnode handle of the next present sub-node.
+ */
+static struct fwnode_handle *
+acpi_get_next_present_subnode(const struct fwnode_handle *fwnode,
+			      struct fwnode_handle *child)
+{
+	do {
+		child = acpi_get_next_subnode(fwnode, child);
+	} while (is_acpi_device_node(child) &&
+		 !acpi_device_is_present(to_acpi_device_node(child)));
+
+	return child;
+}
+
 /**
  * acpi_node_get_parent - Return parent fwnode of this fwnode
  * @fwnode: Firmware node whose parent to get
@@ -1701,7 +1723,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
 		.property_read_string_array =				\
 			acpi_fwnode_property_read_string_array,		\
 		.get_parent = acpi_node_get_parent,			\
-		.get_next_child_node = acpi_get_next_subnode,		\
+		.get_next_child_node = acpi_get_next_present_subnode,	\
 		.get_named_child_node = acpi_fwnode_get_named_child_node, \
 		.get_name = acpi_fwnode_get_name,			\
 		.get_name_prefix = acpi_fwnode_get_name_prefix,		\
-- 
2.51.0


