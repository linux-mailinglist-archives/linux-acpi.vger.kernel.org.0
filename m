Return-Path: <linux-acpi+bounces-18349-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931BAC1C484
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 17:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8AA66243C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC473491E8;
	Wed, 29 Oct 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly00Kxs6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0E34A77A
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755639; cv=none; b=KOzuE3eHfJXeiJhwppxj1rRItgGoIbX0syisRtlUNigqXcNlSrGbTtftxbYfrmERE0fjGkyoXosGpWnqgO9Zg/sK7qKs76w7p2OvLhR83C0++rZ8NuCtzek44PjL8dhj9wugRLuy2TlDImIltpplzkLPGfatWXKzIWbBbxEjeNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755639; c=relaxed/simple;
	bh=oprYoP8yymfB2u4RbgujgsNH+i0ZQOd4dygbCg75p/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY/3/DHPQpFPlxyNEiKCiA5k7A/WhmPhaqryYqGMcOR7zlvMeqhethNEIoUa0YhW2bANPIXpW1TFSSP+wUzuA5cm77O2ymHHWByOzeyYsmOnYbgaMKDF+Pi1reNk6hIywPAUkZcQTFAiDHZupZl7UQKQRjxC7GRZ65zdgoY63Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly00Kxs6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so257422866b.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755634; x=1762360434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7niwucTDN3MnvT2f7z1+zCVDCBNmgQwG7r5182Kk6g=;
        b=ly00Kxs6I33Cts0szvsBGq4htnfjRKgDLfJgp+irQhH6eKg2aQ+FeYSXrktnVcZglE
         LS1X8DzpiRogsiDYx1QlAxeVNlePirHa2e0t8myHtbCX7sceXUAroMRjnaP7pZtJAbGa
         ZQzZ7QGt9Cgzf9F2250kNiJs2S8eGvhA39TaZ7wBXvUJagjjHROm1FCFEM7ezV7ijWgH
         yYqbR7ZF6gG5NFwzSbTizMHnnb6tYgQvX8/iw3UfEgYviyLxh7pJ1sBtoXpBN5ZZsY3J
         VUAZn8FHew4EfgiHNxME1+S8wmyvm3kKigBup4ENf8sONeuxDxeoy2tUw78yc1EHNZon
         eVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755634; x=1762360434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7niwucTDN3MnvT2f7z1+zCVDCBNmgQwG7r5182Kk6g=;
        b=u7NUQ0zylA7OEfe8l3OH0l5VBd43+xMVPbTvVx5WZ++syc9eoP2dTlz/xblLZq8O4k
         lQ8F8oYXXl7fAjcCGriXfpwyAJ0QomchxreEFop7teIN1+YtPXsiJy6tMstlHcl/5N+C
         f7gVmU1dB+miBbwwGCzeYPljKy+Nnz5qcQ9A5iHYvzfIg7zxD8LiNwoRg8HXFaFka3/c
         qE0IJBCYtuIkMk6JTVtJ2jXFsItN574bEXsLcpx6sGeZgX89Y1e7mJbrgX1B3bJh7HCT
         FZ5zrBtCpvUsFVnl9TjYGkiTf3urHDpH2g3b0eCkQ6qxL/rN8YKWIt7JDqr5Qk4zkzOJ
         wwow==
X-Forwarded-Encrypted: i=1; AJvYcCWMqhZqKMoWx+bJqbw/H2qT1LRqNNo4/4SOA4rdNYa7LlsuCSVDMdFJAp6p/SI/qOfOBuUyvWbXGaxL@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFhgl+w08ptWBDPh0rdA6bfdTRiXUMMZwZuqQBZfYqLx58OhT
	EPaSBJRRDczjoz/0mtHOb3VFZFH90nG/WLCkoIiho1EslSWhzA/3w7k8
X-Gm-Gg: ASbGncsXPEn/04hwaoMcD57PhFy1mLRLXQn5xpAA3kMvrcgXcIbs9zbmJtTWscY0MJt
	9XhZC7K0afkAe33oOOWnlycDFDLg4XSgztO6VB1lTza9qWIQLDeI5/4OU7mDRaWeDUGBXB5jfUz
	SK5wJ7Nbop52DvNdTK9FRa7Vm1Dhh5ooaP+Qhv0luGAh0wASyFQuKFpchk2SVqOy/AKdc1z5jFd
	KEmPxxzVktM+TK+q3mpoSWeuvUcgvhMZqBiXrHDa83YEqhiAo+SOjcoQdlenKMKiSbrjY7kQfzH
	N7Rl0KSUWXBbqNg8eGIUCEXXZOSCSJ+IDGPVcr9cDn/I39MsQOJVtmlD9VcW7JQSlWZqxEJpPw0
	KQSX02BPoagcCppkTTw2ikkYiC7ezt99229WxI2Zl2XdLlcwBJWqbYplC9zih00Vh8o9XaJ0udz
	Hk3ESKFo7NZVG9DvceoPlP7xE8QHFsIsPpen8c47+Yy4pDQDxapFHlX5uP675cDYwHQbZ3
X-Google-Smtp-Source: AGHT+IGxst0GGPbE3zlpzuYvmZD7MtT+fgNns/2gbspQBUcAcExwpAJ9gNyBIh9hmr+9IwgchPtgzg==
X-Received: by 2002:a17:906:6a21:b0:b3f:f6d:1d9e with SMTP id a640c23a62f3a-b7051f278acmr28890666b.6.1761755633985;
        Wed, 29 Oct 2025 09:33:53 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d853696a3sm1468789266b.27.2025.10.29.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:52 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] clk: mvebu: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:34 +0100
Message-ID: <20251029163336.2785270-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

 drivers/clk/mvebu/common.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 5adbbd91a6db..8797de93472c 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -189,6 +189,7 @@ void __init mvebu_coreclk_setup(struct device_node *np,
 DEFINE_SPINLOCK(ctrl_gating_lock);
 
 struct clk_gating_ctrl {
+	struct syscore syscore;
 	spinlock_t *lock;
 	struct clk **gates;
 	int num_gates;
@@ -196,11 +197,10 @@ struct clk_gating_ctrl {
 	u32 saved_reg;
 };
 
-static struct clk_gating_ctrl *ctrl;
-
 static struct clk *clk_gating_get_src(
 	struct of_phandle_args *clkspec, void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
 	int n;
 
 	if (clkspec->args_count < 1)
@@ -217,12 +217,16 @@ static struct clk *clk_gating_get_src(
 
 static int mvebu_clk_gating_suspend(void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
+
 	ctrl->saved_reg = readl(ctrl->base);
 	return 0;
 }
 
 static void mvebu_clk_gating_resume(void *data)
 {
+	struct clk_gating_ctrl *ctrl = data;
+
 	writel(ctrl->saved_reg, ctrl->base);
 }
 
@@ -231,13 +235,10 @@ static const struct syscore_ops clk_gate_syscore_ops = {
 	.resume = mvebu_clk_gating_resume,
 };
 
-static struct syscore clk_gate_syscore = {
-	.ops = &clk_gate_syscore_ops,
-};
-
 void __init mvebu_clk_gating_setup(struct device_node *np,
 				   const struct clk_gating_soc_desc *desc)
 {
+	static struct clk_gating_ctrl *ctrl;
 	struct clk *clk;
 	void __iomem *base;
 	const char *default_parent = NULL;
@@ -288,7 +289,9 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 
 	of_clk_add_provider(np, clk_gating_get_src, ctrl);
 
-	register_syscore(&clk_gate_syscore);
+	ctrl->syscore.ops = &clk_gate_syscore_ops;
+	ctrl->syscore.data = ctrl;
+	register_syscore(&ctrl->syscore);
 
 	return;
 gates_out:
-- 
2.51.0


