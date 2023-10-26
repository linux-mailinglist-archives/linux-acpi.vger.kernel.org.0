Return-Path: <linux-acpi+bounces-1011-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBCF7D80E3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 12:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EDE0B21281
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 10:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016403C27
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Oct 2023 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XlIqLy8K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071E29425
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 10:00:58 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D0191;
	Thu, 26 Oct 2023 03:00:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 10EB86607355;
	Thu, 26 Oct 2023 11:00:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698314454;
	bh=0zvIs54+PRjllX9x3XurRLHuEuegL1M0PLHQ0nYXW18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlIqLy8KEXz7h0a36Mxj4EOtZN0xePqBpeqxfZUuDkaJOh3VO7uCXKdIWLDCUG6Pu
	 r3KgbgWbDlAPmrMgbtzHnOWlp2f4S8LM0gPzIMIS0HRAQku2vm5/FZ6xW9vmWK/Cbz
	 WVwhQdl7Cj7Nzi/s8+kUbQHea5rX7b8ocZQk09C2PSwzrfaKlJVIB/dCJSimaJrivD
	 Im59CpwRflcXRr8PSW7MYdUoyuAgDvozv4PYlK4C953moX7RPvL7v3GOQ42KqMK7I3
	 OZFYESqVEStEIeLeJV7RgeNyKCd7suqNZbjtAoDYTe6HkpFy7M7ivWuv9++db/Rm4q
	 wQF+VsQLRRPFQ==
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: broonie@kernel.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rafael@kernel.org,
	robh+dt@kernel.org,
	shuah@kernel.org
Subject: Re: [RFC PATCH 0/2]  Add a test to verify device probing on ACPI platforms
Date: Thu, 26 Oct 2023 12:00:50 +0200
Message-Id: <20231026100050.30704-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230925155806.1812249-1-laura.nao@collabora.com>
References: <20230925155806.1812249-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping to check if there are any feedback or comments on this series.

Thanks,
Laura

