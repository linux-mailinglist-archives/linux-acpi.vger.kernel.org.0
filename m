Return-Path: <linux-acpi+bounces-6975-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB416937A93
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jul 2024 18:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC2C1F22200
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jul 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCB71465A0;
	Fri, 19 Jul 2024 16:13:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75FA13EFEE;
	Fri, 19 Jul 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405627; cv=none; b=KO7nQJ7Bnqr1DR6ucRSYs1PxDWGjswqZjIqcp9DL/qQVAhGknG7Eq3eU57fJvMoOXOxY9ZxCNPnBwnwd6vn39BqqPBZ0fJDA+D0G3Q5P7MGExlM2Pc/jxhsN9sC7rANoBa7PZ5xtm/3g8BN7+TlHvJQeR/98OyxYJF2kSbRMmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405627; c=relaxed/simple;
	bh=99BPPWK6t13YDv0o2y3l9zlKK2T2Nb8+4coT73/pV4o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oDtrxatnotsCIu3xs0KVLnZIvc2f1Ln4CwfW/flxODy7HP4AbRoDvmHJzTZidAq2ZmLXXdQkzhYEitYAzkcvrWk2HyxaAbDMbr6P7EZymQ+aasWFYbrpcqc4sCkWBrxRHus6r3efrbNd9y+4eEE0ITt8W8HrJh3E2CGsORoIgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Li,Rongqing" <lirongqing@baidu.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIXSBBQ1BJOiBSZWZpbmUgYWNwaV9oYW5kbGVfZGVidWcg?=
 =?gb2312?Q?defination?=
Thread-Topic: [PATCH] ACPI: Refine acpi_handle_debug defination
Thread-Index: AQHa2fJN/1gijzVjxEabEpRYm7BHoQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Fri, 19 Jul 2024 15:42:46 +0000
Message-ID: <80d0f67ccaa14bb3abc075e130797812@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex15_2024-07-19 23:42:47:058
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.38
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

TGksUm9uZ3Fpbmcgvauzt7vY08q8/qGwW1BBVENIXSBBQ1BJOiBSZWZpbmUgYWNwaV9oYW5kbGVf
ZGVidWcgZGVmaW5hdGlvbqGxoaM=

