Return-Path: <linux-acpi+bounces-16775-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8959EB55779
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AA9B64732
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94E342CA3;
	Fri, 12 Sep 2025 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+7eBA3e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB9342C98;
	Fri, 12 Sep 2025 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707613; cv=none; b=lB7j9AblA/u3+cvtdawwGfoo5gdjqH9d+ENoxXakmU2yl98bl66wydcAes332LcO8OhcWGQFP7Rj0HHN9vVOvRFwTztuOGWEeaG2MZycPlwIfdC4vJ6HIYmUjQJDOQofg94PTYYxHgPG+bAykOAmE12fv0seGU1xNHxW7P3HeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707613; c=relaxed/simple;
	bh=lsb6zY3uqh4YuxeLz8ERC12aFRzr+uNUEtg0qry4Tko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfctWWkysl7MSWo7UlIPbT6iR/yusEpq0OQQEHdUGw6HX0cR9JIfR/y0y9fPyv5Z7ES/Yk32+6oGx73HxruMqq1nLNsVGQEmJ3cUJdUZkdU9Wod/4C9W8cgYcIq8RlfNLSM6IPrwmWyybEubaX0rbkhAJ5o2JCknzufRKhyKvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+7eBA3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671ABC4CEF9;
	Fri, 12 Sep 2025 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707613;
	bh=lsb6zY3uqh4YuxeLz8ERC12aFRzr+uNUEtg0qry4Tko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+7eBA3eLwtHr3sRdZjgPjzEJUGEsr4eTOaSMdtlnnH4AwRDztwJX2EZF43OdCLBN
	 m5LKVads98BriBOV/5or3uR7yuewufhV8TWds0Dl+b32zr+6odEHVVzbPPfW/yPW3d
	 KuraRlwWBI4hyhoKx6u3+VL3S4ATKGesNrN2BVW6K9hp4cVDYst++S/CfCGfNuwcFU
	 ya0iahSdIhiAv55RWzDS5mMNGDuaDmvU6qGEkj4iIOihMQcREoSUW6tAo3xDqZE3Bg
	 yKKm5WfbvERQTgR4MXWxzCH0rAnKLfS7p75aY1ag6RRx5dXWYarakNRWd8i7csuxON
	 65SSpJAe4gXzA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 05/16] ACPICA: Apply ACPI_NONSTRING
Date: Fri, 12 Sep 2025 21:55:35 +0200
Message-ID: <2042286.usQuhbGJ8B@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2021361.PYKUYFuaPT@rafael.j.wysocki>
References: <2021361.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Ahmed Salem <x0rw3ll@gmail.com>

Add ACPI_NONSTRING for destination char arrays without a terminating NUL
character.

This is a follow-up to commit 2b82118845e0 ("ACPICA: Apply ACPI_NONSTRING")
where a few more destination arrays were missed.

Link: https://github.com/acpica/acpica/commit/f359e5ed
Fixes: 2b82118845e0 ("ACPICA: Apply ACPI_NONSTRING")
Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl.h                                     | 2 +-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 243097a3da63..8a67d4ea6e3f 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -73,7 +73,7 @@ struct acpi_table_header {
 	char oem_id[ACPI_OEM_ID_SIZE] ACPI_NONSTRING;	/* ASCII OEM identification */
 	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE] ACPI_NONSTRING;	/* ASCII OEM table identification */
 	u32 oem_revision;	/* OEM revision number */
-	char asl_compiler_id[ACPI_NAMESEG_SIZE];	/* ASCII ASL compiler vendor ID */
+	char asl_compiler_id[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;	/* ASCII ASL compiler vendor ID */
 	u32 asl_compiler_revision;	/* ASL compiler version */
 };
 
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 9741e7503591..de93067a5da3 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -995,7 +995,7 @@ static acpi_status osl_list_customized_tables(char *directory)
 {
 	void *table_dir;
 	u32 instance;
-	char temp_name[ACPI_NAMESEG_SIZE];
+	char temp_name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	char *filename;
 	acpi_status status = AE_OK;
 
@@ -1312,7 +1312,7 @@ osl_get_customized_table(char *pathname,
 {
 	void *table_dir;
 	u32 current_instance = 0;
-	char temp_name[ACPI_NAMESEG_SIZE];
+	char temp_name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	char table_filename[PATH_MAX];
 	char *filename;
 	acpi_status status;
-- 
2.51.0





