Return-Path: <linux-acpi+bounces-15485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B80AB1970B
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 02:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE957A47CA
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 00:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874380C02;
	Mon,  4 Aug 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOdnHKMl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2EB12DDA1;
	Mon,  4 Aug 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267073; cv=none; b=bk0ZfpMerNxWkwOYl/x1d36duNMVMQW2JzttBjS1GpwPbG+xeVfbzMoP6k2ooWORq1UuiW0xRr7J6M3p6nPhKNdgewcaFJGBKmeegEKCCQ1bVSpWGJ0hH9l7PmU6E+dquuoNzMImdfS5rsHfh6VWMA3XfbygGM1VzUR16vFvVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267073; c=relaxed/simple;
	bh=XsFEYhjgq5AiUdfD3xVjimrYtujktK3Y+Wu3CQSl38k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6mm6adpEbj6raf2TTiQJhIb9eDejO7FIVt0FMMcK03dYmOo+wyfHthzd5PB8mb9cmdP7iKhHx/qMxHeCFiOf7SgzXlAhQMkVW6AF5EMzwc2frRry3Gq4/HXM/ciM4GNuHZ5ZgBKDXyj/oBbTDcMJHlgnojdCatj3R2RAulv51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOdnHKMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4D1C4CEEB;
	Mon,  4 Aug 2025 00:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267073;
	bh=XsFEYhjgq5AiUdfD3xVjimrYtujktK3Y+Wu3CQSl38k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOdnHKMlXZSYS1iy7WPMEimRWO8vcgfRUS0I5+xfYBFTRtYmd9JNopwEOvrMRpzJu
	 3BPaML5db4Zg7bM4LPgd4jqS77IcYASwVnedkB2gMhJAMrMF4ov1hj8XH0tqDgE9M7
	 enpMgcU3UbZmsxG3jxESQMOrttT3F18A+/32gnOKk2rl/X950buIxKj9e34rf5EcKa
	 lfxxJeTOu3QRB5I1SjiVfacKVLcZ1IdbDbymer3xfbD436WGKLvHYev0xlQ+jUurYV
	 5M6ONd697V1hV+JilYqKnohaMBbu6DpHkE7fdNHzD5XVSjkaRPHHCqUqTtMGsqnyeM
	 kLaCrEpGumm3A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jane Chu <jane.chu@oracle.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	ira.weiny@intel.com,
	dave.jiang@intel.com,
	tony.luck@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	leitao@debian.org,
	mingo@kernel.org,
	peterz@infradead.org,
	bp@alien8.de,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16 16/85] ACPI: APEI: send SIGBUS to current task if synchronous memory error not recovered
Date: Sun,  3 Aug 2025 20:22:25 -0400
Message-Id: <20250804002335.3613254-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002335.3613254-1-sashal@kernel.org>
References: <20250804002335.3613254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Shuai Xue <xueshuai@linux.alibaba.com>

[ Upstream commit 79a5ae3c4c5eb7e38e0ebe4d6bf602d296080060 ]

If a synchronous error is detected as a result of user-space process
triggering a 2-bit uncorrected error, the CPU will take a synchronous
error exception such as Synchronous External Abort (SEA) on Arm64. The
kernel will queue a memory_failure() work which poisons the related
page, unmaps the page, and then sends a SIGBUS to the process, so that
a system wide panic can be avoided.

However, no memory_failure() work will be queued when abnormal
synchronous errors occur. These errors can include situations like
invalid PA, unexpected severity, no memory failure config support,
invalid GUID section, etc. In such a case, the user-space process will
trigger SEA again.  This loop can potentially exceed the platform
firmware threshold or even trigger a kernel hard lockup, leading to a
system reboot.

Fix it by performing a force kill if no memory_failure() work is queued
for synchronous errors.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Link: https://patch.msgid.link/20250714114212.31660-2-xueshuai@linux.alibaba.com
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Critical Bug Fix**: The commit fixes a serious issue where
   synchronous memory errors that cannot be recovered (abnormal
   synchronous errors) would cause an infinite loop. The commit message
   clearly describes how "the user-space process will trigger SEA again.
   This loop can potentially exceed the platform firmware threshold or
   even trigger a kernel hard lockup, leading to a system reboot."

2. **Security and Stability Impact**: The bug can lead to:
   - Infinite exception loops
   - Platform firmware threshold exceeded
   - Kernel hard lockups
   - Unexpected system reboots

   These are severe stability issues that affect system reliability.

3. **Small and Contained Fix**: The code change is minimal and well-
   contained:
  ```c
  + /*
  +  * If no memory failure work is queued for abnormal synchronous
  +  * errors, do a force kill.
  +  */
  + if (sync && !queued) {
  +     dev_err(ghes->dev,
  +         HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error
  (SIGBUS)\n",
  +         current->comm, task_pid_nr(current));
  +     force_sig(SIGBUS);
  + }
  ```
  The fix adds only 10 lines of code that check if we're in a
  synchronous context (`sync`) and no memory failure work was queued
  (`!queued`), then sends SIGBUS to the current process.

4. **Clear Problem and Solution**: The commit addresses a specific gap
   in error handling. When `ghes_handle_memory_failure()` returns false
   (meaning no memory_failure() work was queued) for synchronous errors,
   the process that triggered the error continues execution and will hit
   the same error again, creating an infinite loop.

5. **Follows Stable Rules**: This fix meets the stable kernel criteria:
   - Fixes a real bug that affects users
   - Small change (< 100 lines)
   - Obviously correct and tested (has multiple Reviewed-by tags)
   - Does not add new features
   - Addresses a serious issue (system stability/reboot)

6. **Related to Previous Work**: This appears to be part of a series
   addressing synchronous error handling issues in GHES. The commit
   c1f1fda14137 mentioned in the git log shows ongoing work to properly
   handle synchronous exceptions, and this commit addresses a critical
   gap where abnormal synchronous errors weren't being handled at all.

The fix ensures that when a synchronous memory error cannot be properly
handled through the normal memory_failure() path, the kernel will at
least terminate the offending process with SIGBUS rather than allowing
it to continue and create an infinite exception loop that can crash the
system.

 drivers/acpi/apei/ghes.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0584ccad451..281a0a2f6730 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -902,6 +902,17 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 	}
 
+	/*
+	 * If no memory failure work is queued for abnormal synchronous
+	 * errors, do a force kill.
+	 */
+	if (sync && !queued) {
+		dev_err(ghes->dev,
+			HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
+			current->comm, task_pid_nr(current));
+		force_sig(SIGBUS);
+	}
+
 	return queued;
 }
 
-- 
2.39.5


