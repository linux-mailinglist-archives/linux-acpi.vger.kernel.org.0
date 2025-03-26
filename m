Return-Path: <linux-acpi+bounces-12440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5FAA71BA7
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628FB172030
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595131F560D;
	Wed, 26 Mar 2025 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq7N9B/R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E31F4288;
	Wed, 26 Mar 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006037; cv=none; b=uOon1wssGpW42h32aUyWw1SKIlXqoP61YGLhEgrgZzD5v+6Xas4Vwqi4KFLHeOPo7PNvb7w20A8ay6gjpQwwOSwFrnuaIEuczqWFh9lrL5AFrAjfZu1oOrnNm2hMIWNCRNosNc7lPhTQXkL1RXcV/ec1RMSGLmUUwiNwL5mMhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006037; c=relaxed/simple;
	bh=fT6vyJWXrJFHw+WHik05GpC0tIuzAUjJrqq+9ioaJ28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VFDeQyNMT2iZjGb6pqpkF28K1lGWT6KDSyt+ZRPcmKMWoj/JYk9od6CB6m81guQeYYrjcXdd+n98sPzrPobYF1kLj3J0vOQudyyRNTbnTyQVF/zyR9v46nHsREuAUzvJTtsCjKfOTnPRnR41skc6CUO9fQ9YSO6FkpaGz1qY6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq7N9B/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935AEC4CEE2;
	Wed, 26 Mar 2025 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743006036;
	bh=fT6vyJWXrJFHw+WHik05GpC0tIuzAUjJrqq+9ioaJ28=;
	h=Date:From:To:Cc:Subject:From;
	b=Wq7N9B/RN+ANt1/83FYQTcsxpMqD8FjnMwsi2/GwKCQenlhzYe12JWTXPJO0fSv+K
	 /6mXFtTaA/QCXveVjhmlMnq+K40++8pYS1dNaQsaDw+I1Moe56VHtViyXWqe3ec68J
	 f6/6A/uleeb7hRRqgDTmIGSnfDXEn1o+QT1ZCjLmLPq9tteZxA4URWT80cbgh43yt0
	 GHfJYVo7OdmhMHsYMdrPpe76tDYXqmw9gXjdIecuSvsHnK6rYv2IIie2Vdh/MG9cJH
	 B5VeIP5EZa9Cn9rBIIx2l0qAiLTRDND1xYw4ZKND3awO+5gWskDKm1mTMiT9UVq22n
	 noLgx7B+gxgew==
Date: Wed, 26 Mar 2025 10:20:33 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] acpi: nfit: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z-QpUcxFCRByYcTA@kspp>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix a dozen of the following warnings:

drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use DEFINE_RAW_FLEX() instead of __struct_group().

v1:
 - Link: https://lore.kernel.org/linux-hardening/Z618ILbAR8YAvTkd@kspp/

 drivers/acpi/nfit/intel.c | 388 ++++++++++++++++++--------------------
 1 file changed, 179 insertions(+), 209 deletions(-)

diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 3902759abcba..114d5b3bb39b 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -55,21 +55,17 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned long security_flags = 0;
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_get_security_state cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_out =
-				sizeof(struct nd_intel_get_security_state),
-			.nd_fw_size =
-				sizeof(struct nd_intel_get_security_state),
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_get_security_state));
+	struct nd_intel_get_security_state *cmd =
+			(struct nd_intel_get_security_state *)nd_cmd->nd_payload;
 	int rc;
 
+	nd_cmd->nd_command = NVDIMM_INTEL_GET_SECURITY_STATE;
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_out = sizeof(struct nd_intel_get_security_state);
+	nd_cmd->nd_fw_size = sizeof(struct nd_intel_get_security_state);
+
 	if (!test_bit(NVDIMM_INTEL_GET_SECURITY_STATE, &nfit_mem->dsm_mask))
 		return 0;
 
@@ -81,33 +77,34 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 	if (nvdimm_in_overwrite(nvdimm) && ptype == NVDIMM_USER)
 		return BIT(NVDIMM_SECURITY_OVERWRITE);
 
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
-	if (rc < 0 || nd_cmd.cmd.status) {
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
+	if (rc < 0 || cmd->status) {
 		pr_err("%s: security state retrieval failed (%d:%#x)\n",
-				nvdimm_name(nvdimm), rc, nd_cmd.cmd.status);
+				nvdimm_name(nvdimm), rc, cmd->status);
 		return 0;
 	}
 
 	/* check and see if security is enabled and locked */
 	if (ptype == NVDIMM_MASTER) {
-		if (nd_cmd.cmd.extended_state & ND_INTEL_SEC_ESTATE_ENABLED)
+		if (cmd->extended_state & ND_INTEL_SEC_ESTATE_ENABLED)
 			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
 		else
 			set_bit(NVDIMM_SECURITY_DISABLED, &security_flags);
-		if (nd_cmd.cmd.extended_state & ND_INTEL_SEC_ESTATE_PLIMIT)
+		if (cmd->extended_state & ND_INTEL_SEC_ESTATE_PLIMIT)
 			set_bit(NVDIMM_SECURITY_FROZEN, &security_flags);
 		return security_flags;
 	}
 
-	if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_UNSUPPORTED)
+	if (cmd->state & ND_INTEL_SEC_STATE_UNSUPPORTED)
 		return 0;
 
-	if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_ENABLED) {
-		if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_FROZEN ||
-		    nd_cmd.cmd.state & ND_INTEL_SEC_STATE_PLIMIT)
+	if (cmd->state & ND_INTEL_SEC_STATE_ENABLED) {
+		if (cmd->state & ND_INTEL_SEC_STATE_FROZEN ||
+		    cmd->state & ND_INTEL_SEC_STATE_PLIMIT)
 			set_bit(NVDIMM_SECURITY_FROZEN, &security_flags);
 
-		if (nd_cmd.cmd.state & ND_INTEL_SEC_STATE_LOCKED)
+		if (cmd->state & ND_INTEL_SEC_STATE_LOCKED)
 			set_bit(NVDIMM_SECURITY_LOCKED, &security_flags);
 		else
 			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);
@@ -120,26 +117,25 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
 static int intel_security_freeze(struct nvdimm *nvdimm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_freeze_lock cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_FREEZE_LOCK,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_out = ND_INTEL_STATUS_SIZE,
-			.nd_fw_size = ND_INTEL_STATUS_SIZE,
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_freeze_lock));
+	struct nd_intel_freeze_lock *cmd =
+			(struct nd_intel_freeze_lock *)nd_cmd->nd_payload;
 	int rc;
 
+	nd_cmd->nd_command = NVDIMM_INTEL_FREEZE_LOCK;
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_out = ND_INTEL_STATUS_SIZE;
+	nd_cmd->nd_fw_size = ND_INTEL_STATUS_SIZE;
+
 	if (!test_bit(NVDIMM_INTEL_FREEZE_LOCK, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
 	if (rc < 0)
 		return rc;
-	if (nd_cmd.cmd.status)
+	if (cmd->status)
 		return -EIO;
 	return 0;
 }
@@ -153,32 +149,31 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_SET_MASTER_PASSPHRASE :
 		NVDIMM_INTEL_SET_PASSPHRASE;
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_set_passphrase cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE * 2,
-			.nd_size_out = ND_INTEL_STATUS_SIZE,
-			.nd_fw_size = ND_INTEL_STATUS_SIZE,
-			.nd_command = cmd,
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_set_passphrase));
+	struct nd_intel_set_passphrase *cmd_pp =
+			(struct nd_intel_set_passphrase *)nd_cmd->nd_payload;
 	int rc;
 
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_in = ND_INTEL_PASSPHRASE_SIZE * 2;
+	nd_cmd->nd_size_out = ND_INTEL_STATUS_SIZE;
+	nd_cmd->nd_fw_size = ND_INTEL_STATUS_SIZE;
+	nd_cmd->nd_command = cmd;
+
 	if (!test_bit(cmd, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
-	memcpy(nd_cmd.cmd.old_pass, old_data->data,
-			sizeof(nd_cmd.cmd.old_pass));
-	memcpy(nd_cmd.cmd.new_pass, new_data->data,
-			sizeof(nd_cmd.cmd.new_pass));
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+	memcpy(cmd_pp->old_pass, old_data->data,
+			sizeof(cmd_pp->old_pass));
+	memcpy(cmd_pp->new_pass, new_data->data,
+			sizeof(cmd_pp->new_pass));
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
 	if (rc < 0)
 		return rc;
 
-	switch (nd_cmd.cmd.status) {
+	switch (cmd_pp->status) {
 	case 0:
 		return 0;
 	case ND_INTEL_STATUS_INVALID_PASS:
@@ -195,29 +190,28 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_unlock_unit cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_UNLOCK_UNIT,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE,
-			.nd_size_out = ND_INTEL_STATUS_SIZE,
-			.nd_fw_size = ND_INTEL_STATUS_SIZE,
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_unlock_unit));
+	struct nd_intel_unlock_unit *cmd =
+			(struct nd_intel_unlock_unit *)nd_cmd->nd_payload;
 	int rc;
 
+	nd_cmd->nd_command = NVDIMM_INTEL_UNLOCK_UNIT;
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_in = ND_INTEL_PASSPHRASE_SIZE;
+	nd_cmd->nd_size_out = ND_INTEL_STATUS_SIZE;
+	nd_cmd->nd_fw_size = ND_INTEL_STATUS_SIZE;
+
 	if (!test_bit(NVDIMM_INTEL_UNLOCK_UNIT, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
-	memcpy(nd_cmd.cmd.passphrase, key_data->data,
-			sizeof(nd_cmd.cmd.passphrase));
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+	memcpy(cmd->passphrase, key_data->data,
+			sizeof(cmd->passphrase));
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
 	if (rc < 0)
 		return rc;
-	switch (nd_cmd.cmd.status) {
+	switch (cmd->status) {
 	case 0:
 		break;
 	case ND_INTEL_STATUS_INVALID_PASS:
@@ -234,29 +228,28 @@ static int intel_security_disable(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_disable_passphrase cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_DISABLE_PASSPHRASE,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE,
-			.nd_size_out = ND_INTEL_STATUS_SIZE,
-			.nd_fw_size = ND_INTEL_STATUS_SIZE,
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_disable_passphrase));
+	struct nd_intel_disable_passphrase *cmd =
+			(struct nd_intel_disable_passphrase *)nd_cmd->nd_payload;
+
+	nd_cmd->nd_command = NVDIMM_INTEL_DISABLE_PASSPHRASE;
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_in = ND_INTEL_PASSPHRASE_SIZE;
+	nd_cmd->nd_size_out = ND_INTEL_STATUS_SIZE;
+	nd_cmd->nd_fw_size = ND_INTEL_STATUS_SIZE;
 
 	if (!test_bit(NVDIMM_INTEL_DISABLE_PASSPHRASE, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
-	memcpy(nd_cmd.cmd.passphrase, key_data->data,
-			sizeof(nd_cmd.cmd.passphrase));
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+	memcpy(cmd->passphrase, key_data->data,
+			sizeof(cmd->passphrase));
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
 	if (rc < 0)
 		return rc;
 
-	switch (nd_cmd.cmd.status) {
+	switch (cmd->status) {
 	case 0:
 		break;
 	case ND_INTEL_STATUS_INVALID_PASS:
@@ -277,29 +270,28 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_MASTER_SECURE_ERASE : NVDIMM_INTEL_SECURE_ERASE;
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_secure_erase cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE,
-			.nd_size_out = ND_INTEL_STATUS_SIZE,
-			.nd_fw_size = ND_INTEL_STATUS_SIZE,
-			.nd_command = cmd,
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_secure_erase));
+	struct nd_intel_secure_erase *cmd_se =
+			(struct nd_intel_secure_erase *)nd_cmd->nd_payload;
+
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_in = ND_INTEL_PASSPHRASE_SIZE;
+	nd_cmd->nd_size_out = ND_INTEL_STATUS_SIZE;
+	nd_cmd->nd_fw_size = ND_INTEL_STATUS_SIZE;
+	nd_cmd->nd_command = cmd;
 
 	if (!test_bit(cmd, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
-	memcpy(nd_cmd.cmd.passphrase, key->data,
-			sizeof(nd_cmd.cmd.passphrase));
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+	memcpy(cmd_se->passphrase, key->data,
+			sizeof(cmd_se->passphrase));
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
 	if (rc < 0)
 		return rc;
 
-	switch (nd_cmd.cmd.status) {
+	switch (cmd_se->status) {
 	case 0:
 		break;
 	case ND_INTEL_STATUS_NOT_SUPPORTED:
@@ -318,26 +310,25 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_query_overwrite cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_QUERY_OVERWRITE,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_out = ND_INTEL_STATUS_SIZE,
-			.nd_fw_size = ND_INTEL_STATUS_SIZE,
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_query_overwrite));
+	struct nd_intel_query_overwrite *cmd =
+			(struct nd_intel_query_overwrite *)nd_cmd->nd_payload;
+
+	nd_cmd->nd_command = NVDIMM_INTEL_QUERY_OVERWRITE;
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_out = ND_INTEL_STATUS_SIZE;
+	nd_cmd->nd_fw_size = ND_INTEL_STATUS_SIZE;
 
 	if (!test_bit(NVDIMM_INTEL_QUERY_OVERWRITE, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
 	if (rc < 0)
 		return rc;
 
-	switch (nd_cmd.cmd.status) {
+	switch (cmd->status) {
 	case 0:
 		break;
 	case ND_INTEL_STATUS_OQUERY_INPROGRESS:
@@ -354,29 +345,28 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_overwrite cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_OVERWRITE,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_in = ND_INTEL_PASSPHRASE_SIZE,
-			.nd_size_out = ND_INTEL_STATUS_SIZE,
-			.nd_fw_size = ND_INTEL_STATUS_SIZE,
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_overwrite));
+	struct nd_intel_overwrite *cmd =
+			(struct nd_intel_overwrite *)nd_cmd->nd_payload;
+
+	nd_cmd->nd_command = NVDIMM_INTEL_OVERWRITE;
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_in = ND_INTEL_PASSPHRASE_SIZE;
+	nd_cmd->nd_size_out = ND_INTEL_STATUS_SIZE;
+	nd_cmd->nd_fw_size = ND_INTEL_STATUS_SIZE;
 
 	if (!test_bit(NVDIMM_INTEL_OVERWRITE, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
-	memcpy(nd_cmd.cmd.passphrase, nkey->data,
-			sizeof(nd_cmd.cmd.passphrase));
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+	memcpy(cmd->passphrase, nkey->data,
+			sizeof(cmd->passphrase));
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
 	if (rc < 0)
 		return rc;
 
-	switch (nd_cmd.cmd.status) {
+	switch (cmd->status) {
 	case 0:
 		return 0;
 	case ND_INTEL_STATUS_OVERWRITE_UNSUPPORTED:
@@ -407,24 +397,18 @@ const struct nvdimm_security_ops *intel_security_ops = &__intel_security_ops;
 static int intel_bus_fwa_businfo(struct nvdimm_bus_descriptor *nd_desc,
 		struct nd_intel_bus_fw_activate_businfo *info)
 {
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_bus_fw_activate_businfo cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO,
-			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
-			.nd_size_out =
-				sizeof(struct nd_intel_bus_fw_activate_businfo),
-			.nd_fw_size =
-				sizeof(struct nd_intel_bus_fw_activate_businfo),
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_bus_fw_activate_businfo));
 	int rc;
 
-	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd),
-			NULL);
-	*info = nd_cmd.cmd;
+	nd_cmd->nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE_BUSINFO;
+	nd_cmd->nd_family = NVDIMM_BUS_FAMILY_INTEL;
+	nd_cmd->nd_size_out = sizeof(struct nd_intel_bus_fw_activate_businfo);
+	nd_cmd->nd_fw_size = sizeof(struct nd_intel_bus_fw_activate_businfo);
+
+	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_CALL, nd_cmd,
+			    __struct_size(nd_cmd), NULL);
+	*info = *(struct nd_intel_bus_fw_activate_businfo *)nd_cmd->nd_payload;
 	return rc;
 }
 
@@ -518,33 +502,28 @@ static enum nvdimm_fwa_capability intel_bus_fwa_capability(
 static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_bus_fw_activate cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE,
-			.nd_family = NVDIMM_BUS_FAMILY_INTEL,
-			.nd_size_in = sizeof(nd_cmd.cmd.iodev_state),
-			.nd_size_out =
-				sizeof(struct nd_intel_bus_fw_activate),
-			.nd_fw_size =
-				sizeof(struct nd_intel_bus_fw_activate),
-		},
-		/*
-		 * Even though activate is run from a suspended context,
-		 * for safety, still ask platform firmware to force
-		 * quiesce devices by default. Let a module
-		 * parameter override that policy.
-		 */
-		.cmd = {
-			.iodev_state = acpi_desc->fwa_noidle
-				? ND_INTEL_BUS_FWA_IODEV_OS_IDLE
-				: ND_INTEL_BUS_FWA_IODEV_FORCE_IDLE,
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_bus_fw_activate));
+	struct nd_intel_bus_fw_activate *cmd =
+			(struct nd_intel_bus_fw_activate *)nd_cmd->nd_payload;
 	int rc;
 
+	nd_cmd->nd_command = NVDIMM_BUS_INTEL_FW_ACTIVATE;
+	nd_cmd->nd_family = NVDIMM_BUS_FAMILY_INTEL;
+	nd_cmd->nd_size_in = sizeof(cmd->iodev_state);
+	nd_cmd->nd_size_out = sizeof(struct nd_intel_bus_fw_activate);
+	nd_cmd->nd_fw_size = sizeof(struct nd_intel_bus_fw_activate);
+
+	/*
+	 * Even though activate is run from a suspended context,
+	 * for safety, still ask platform firmware to force
+	 * quiesce devices by default. Let a module
+	 * parameter override that policy.
+	 */
+	cmd->iodev_state = acpi_desc->fwa_noidle
+				? ND_INTEL_BUS_FWA_IODEV_OS_IDLE
+				: ND_INTEL_BUS_FWA_IODEV_FORCE_IDLE;
+
 	switch (intel_bus_fwa_state(nd_desc)) {
 	case NVDIMM_FWA_ARMED:
 	case NVDIMM_FWA_ARM_OVERFLOW:
@@ -553,8 +532,8 @@ static int intel_bus_fwa_activate(struct nvdimm_bus_descriptor *nd_desc)
 		return -ENXIO;
 	}
 
-	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd),
-			NULL);
+	rc = nd_desc->ndctl(nd_desc, NULL, ND_CMD_CALL, nd_cmd,
+			    __struct_size(nd_cmd), NULL);
 
 	/*
 	 * Whether the command succeeded, or failed, the agent checking
@@ -582,23 +561,18 @@ const struct nvdimm_bus_fw_ops *intel_bus_fw_ops = &__intel_bus_fw_ops;
 static int intel_fwa_dimminfo(struct nvdimm *nvdimm,
 		struct nd_intel_fw_activate_dimminfo *info)
 {
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_fw_activate_dimminfo cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_out =
-				sizeof(struct nd_intel_fw_activate_dimminfo),
-			.nd_fw_size =
-				sizeof(struct nd_intel_fw_activate_dimminfo),
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_fw_activate_dimminfo));
 	int rc;
 
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
-	*info = nd_cmd.cmd;
+	nd_cmd->nd_command = NVDIMM_INTEL_FW_ACTIVATE_DIMMINFO;
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_out = sizeof(struct nd_intel_fw_activate_dimminfo);
+	nd_cmd->nd_fw_size = sizeof(struct nd_intel_fw_activate_dimminfo);
+
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
+	*info = *(struct nd_intel_fw_activate_dimminfo *)nd_cmd->nd_payload;
 	return rc;
 }
 
@@ -688,27 +662,22 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	struct acpi_nfit_desc *acpi_desc = nfit_mem->acpi_desc;
-	struct {
-		struct nd_cmd_pkg pkg;
-		struct nd_intel_fw_activate_arm cmd;
-	} nd_cmd = {
-		.pkg = {
-			.nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM,
-			.nd_family = NVDIMM_FAMILY_INTEL,
-			.nd_size_in = sizeof(nd_cmd.cmd.activate_arm),
-			.nd_size_out =
-				sizeof(struct nd_intel_fw_activate_arm),
-			.nd_fw_size =
-				sizeof(struct nd_intel_fw_activate_arm),
-		},
-		.cmd = {
-			.activate_arm = arm == NVDIMM_FWA_ARM
-				? ND_INTEL_DIMM_FWA_ARM
-				: ND_INTEL_DIMM_FWA_DISARM,
-		},
-	};
+	DEFINE_RAW_FLEX(struct nd_cmd_pkg, nd_cmd, nd_payload,
+			sizeof(struct nd_intel_fw_activate_arm));
+	struct nd_intel_fw_activate_arm *cmd =
+			(struct nd_intel_fw_activate_arm *)nd_cmd->nd_payload;
 	int rc;
 
+	nd_cmd->nd_command = NVDIMM_INTEL_FW_ACTIVATE_ARM;
+	nd_cmd->nd_family = NVDIMM_FAMILY_INTEL;
+	nd_cmd->nd_size_in = sizeof(cmd->activate_arm);
+	nd_cmd->nd_size_out = sizeof(struct nd_intel_fw_activate_arm);
+	nd_cmd->nd_fw_size = sizeof(struct nd_intel_fw_activate_arm);
+
+	cmd->activate_arm = arm == NVDIMM_FWA_ARM
+					? ND_INTEL_DIMM_FWA_ARM
+					: ND_INTEL_DIMM_FWA_DISARM;
+
 	switch (intel_fwa_state(nvdimm)) {
 	case NVDIMM_FWA_INVALID:
 		return -ENXIO;
@@ -733,7 +702,8 @@ static int intel_fwa_arm(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arm)
 	acpi_desc->fwa_state = NVDIMM_FWA_INVALID;
 	nfit_mem->fwa_state = NVDIMM_FWA_INVALID;
 
-	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
+	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, nd_cmd, __struct_size(nd_cmd),
+			NULL);
 
 	dev_dbg(acpi_desc->dev, "%s result: %d\n", arm == NVDIMM_FWA_ARM
 			? "arm" : "disarm", rc);
-- 
2.43.0


