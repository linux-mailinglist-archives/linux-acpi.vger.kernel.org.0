Return-Path: <linux-acpi+bounces-13392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FC9AA541E
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 20:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3B71C02CAC
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A54265CCB;
	Wed, 30 Apr 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksxg+wR7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645D1E5B9C;
	Wed, 30 Apr 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039049; cv=none; b=Ew5wBIu8TpxQMjXDZuZz642Y+7g+0fGKfnriE6+jnvZ7UtZW2qnRputqCOGt2vjRtMk9/hQg6KuCNeAjHUJ4xBdb58u3id9h9DMjlKhMra4dXWSnk+g+8G+lBUjSrpH7Itvon1u6KjUGDgks1Lr/71GroteE4zCgI5kLiZGcQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039049; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mh0pcMPAqVDpKVbUxz01dwKBUn7Zqo5GHTxjy3O+Zu2dLmoGXzwZmamQt3osptuTs00s/Q6qko88S4aRel7eYmNCPR2bbWdl/tw+8WbPxFnUsWWBD5F0huJdBIbaZh94s7pC1dWSy4u8m8lVGXY0UjgnXdYXdRBZs6C5qV8VO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksxg+wR7; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736a7e126c7so233316b3a.3;
        Wed, 30 Apr 2025 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746039047; x=1746643847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ksxg+wR7pRCWhoGtxGPFVYAu3sPY69MXNjeZRCtJoKyglTXuz+nibQmf/5c/gu/oBQ
         KskTXYbIZ3BuQhNyLMPi2CnkVI4rxo0ULuTN1aO5HRVgXHVGrhduqFkD3hhlnEp92Ybw
         0G6vcIKeN5uzVbW/WAPviTADIVA9pemIhnVqRBkpYXXxP+WtGBhEVpUu1X+jeocOvczg
         NgHqzgMbsgBWnBhCDu/f4jZS5n0sVn4rZFO0mIynMKbc7krbaER2jkDls5DlduObfcd8
         ObMRG95kVHkVY1GnCk1H2Vn7wPYgZtUWCEpSt8HTdrjEpbcvhK+Lx4BcfvaVxWQvDFRW
         VlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746039047; x=1746643847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=OjSfQ3wioufw0fm8G/hVxK90kIrgj1QdcwVNV/NlIBv5V7HQOaiQ7qYzwcmLf2cHjP
         cNFLtqtfcj0R6SyHQpXMMleeiMKSNhCfWV19bdy6wWyeNrGkhqzzwD6sg+HYEVD5FnFT
         LRRu78aTqu4c0goiXDi4vFNaBArHBzbVrf9TwOAxFDlkAZ3p0jGo4UnCFnAv6m1nBi3o
         7yD/rjco5HGdinq+nPkYD3ItXyQuL6dUT1maAFf/1HRFKpQlFzKFjS5GA5GgPclPyGeU
         a95unHU+xNwv0rekO07IX9pd4C4eCQPWoFC1LhoIYD+w6i8+ARgCxVuv8kyFV6eFy9xV
         Wd0A==
X-Forwarded-Encrypted: i=1; AJvYcCWfQ39tpgFFllHO5WE9mHx3Vg8B3kinzul1aIt1us1S1zO8mDpwbSBA7RIcX28LtMU/U96ySDnp/xQNZbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLFySA98uj6GRAaKPbrE2UriNPnO0AnnVBqyXUNWno1dJsjgh
	tLGkm5RpChHhAGdjydu2zpTSqLjoedIDGT4uoACSJ0xsD+g6z8lNxJWkzw==
X-Gm-Gg: ASbGncs2l0oQWbhKOaQ67E2gHzBbZQL8Wu9haC7GsjZz76H1EAwjDIpTziKewtujA46
	+y6i9fp0mp7Ndn0GbOXmJqxKTxAnmQrnZF2vmtycnKH0DR7BjVZrj1T0IVRfv2C3aVkd2oPy4EL
	QEQ7VjqfzKsRk3WRaAtTqO1rOkwv8EEVaw2ZH9TpdaujVMo8C/pHli/IlhctGoI3LQj+7fPOKzb
	F6rHhIf+LWo08stlxGwtqhxs4KMxHzyKqyfEjvF5DaMAF/daCVz7UrautOBnH1FH8uz74bm5cbD
	pL//r6RIsU+Rk2YWk3UurZMyET/MQAZsmOoB22t0ouTRjPUHmmbO9WU/brclSNfV2F9AkA==
X-Google-Smtp-Source: AGHT+IG23Kj8sV5VT7/yABcoNRoFKA7+MckqIHDIMbmJ0B9og5LDMVZmkxQjN6Xxbr4gHJZk9ZsdnA==
X-Received: by 2002:a05:6a00:1909:b0:736:62a8:e52d with SMTP id d2e1a72fcca58-7403a7a4c90mr5529180b3a.12.1746039047025;
        Wed, 30 Apr 2025 11:50:47 -0700 (PDT)
Received: from tamird-mac.thefacebook.com ([2620:10d:c090:500::5:c4c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a309edsm2086041b3a.91.2025.04.30.11.50.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 11:50:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robert.moore@intel.com,
	saket.dumbre@intel.com
Subject: [PATCH 0/0] Cover letter only
Date: Wed, 30 Apr 2025 11:48:40 -0700
Message-ID: <20250430185019.19528-3-tamird@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <4664267.LvFx2qVVIh@rjwysocki.net>
References: <4664267.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


