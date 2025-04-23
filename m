Return-Path: <linux-acpi+bounces-13196-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8DA9808F
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Apr 2025 09:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76050188C99F
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Apr 2025 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6972676DF;
	Wed, 23 Apr 2025 07:22:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3441F03D6;
	Wed, 23 Apr 2025 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392956; cv=none; b=ZJp6iIygkZQ/ZEo6IKUN+O8O09HRH+qhXJmPGUDN45MPQkE/rmMtBjJqAxgeiDeuOCynW9eIYgR2SQ3WUBRNh5J8568PsHWdk0nZE4L5Nz+uHd7SmG0bKthlY7eYqlsZjNwLL22iv/j979jTSGM+AxY7ziThSqaUi6sjVniyczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392956; c=relaxed/simple;
	bh=8E+yH1yJ9anEDvc1syuSaYy7hMxC0BNHz0AaSQnyjz0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=i0fOWq8awaFJl7vyhL59tRgtmRFR6Bfk78JUQVSXYHHbfxUJGU++2GIqMzCYze8tE07AFXd9SMqKeR1vCUXZ99AL/uoqw6KxZEucGqrkDBIHr3XLLQHP3wdNCjvKhPJdtnm1nHyd2nOog/XMlVl6aylrSxXRZnPSCVlOTsnaFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67A11063;
	Wed, 23 Apr 2025 00:22:28 -0700 (PDT)
Received: from [10.163.52.223] (unknown [10.163.52.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED0753F66E;
	Wed, 23 Apr 2025 00:22:30 -0700 (PDT)
Message-ID: <edf62d1b-54c0-4e03-96fa-08048b258bfd@arm.com>
Date: Wed, 23 Apr 2025 12:52:26 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Build warning on drivers/acpi/tables.c:399
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Getting the following build warning with native arm64 gcc (Debian 10.2.1-6) 10.2.1
20210110 and with arm64 cross compiler as well.

drivers/acpi/tables.c:399:1: warning: ‘nonstring’ attribute ignored on objects of type ‘const char[][4]’ [-Wattributes]
  399 | static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst __nonstring = {                                                                                                                      
      | ^~~~~~               

This is caused by a recent commit 4b4bd8c50f48 ("gcc-15: acpi: sprinkle random
'__nonstring' crumbles around"). Should that __nonstring attribute for table_sigsp[][]
be dropped off ? Apparently __nonstring attribute only applies for character arrays but
not applicable for arrays of character arrays.

- Anshuman

