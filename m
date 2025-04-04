Return-Path: <linux-acpi+bounces-12731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A7CA7B8C6
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 10:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D99D189CC6D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B4D19539F;
	Fri,  4 Apr 2025 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElIdxmOn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E61624E9;
	Fri,  4 Apr 2025 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755078; cv=none; b=hCfya8fmC1PLVyJQ0TYrJuqQBSyi5xgn705JVz3kWatpshONZ6GxobPCq2HfGg74Oi8c20QM5gslWQQlrfpV5enTit+HEIQkr2hz19hqFY8e6SSfdfDxo8hC3twvs9MGDxmgPNZRrQDsWnlFms7L7sIBNVfSf82UOKpYvp6fyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755078; c=relaxed/simple;
	bh=O+GAE5Vzbp65UqRHmQTuY00tUUYdLuUU21KF3CXm+jA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A/LNc6gavQ3t8d7rlBFUE8mX+/3cGoBD9LBWqOuzKOF6bF+JKKUO4bakwQy/I1TrswURs6tFvcMBg/cajTs5qw85whYmgQl3gp1z9ajzBLK1WtvX+51FFagDcf2mSb7Txd0KNwXZypuiNjawSx2OiDc+lFCJRRN/aKw0/7R+PDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElIdxmOn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac29fd22163so300734566b.3;
        Fri, 04 Apr 2025 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743755075; x=1744359875; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8Q4hgwLYaVKLcAdMEHefEZY3heGKBcISCd2gGVlBqQ=;
        b=ElIdxmOnW8/ELDGqc6LFszm6gQERJoWCNdsZzorjCs5b3r0RxktNSylsY7w9uHhd6L
         odFDQPCj91Q+tBEE9QDGTRbYOr8PRV38r8BpJp5aBBcQw/uaQStYCsSFBdO+KMJ2UcXB
         ftUGVnPDBLiuLvFF0MlrLlBk8uCCa1bPxTTJHFn+t94Zx5k8y5XDBJN+j9zr9hW4k3d8
         bqUxv7hpr/vCi9cj6uByzZDHNjxeH8B81Pq9XIiBGamjSikB1LJ1waZgZAhF/+yGME1S
         XMhG1+/+0nZOgoAqcErUrFAg1vWdjMSQMJHC6PPelF50wTH00IwXk5FFsGgvIh6MomPe
         1fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755075; x=1744359875;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8Q4hgwLYaVKLcAdMEHefEZY3heGKBcISCd2gGVlBqQ=;
        b=Agv3oqyG0ilJQqg10Nz25LG2Xn5zVdB+al9e5Zb5zNPyPAcJG4blwJ6c9t6y19exLX
         iIsZemKP5NiuGkjFbRjTLsEReH/eiRIe5/OT8ODelirWp3JpS48OnT8AlK6caDFZ72F/
         /FDaK12IO08Cona3NdaoTrH2fjtI2Z98pRdWAxXecbDLSvXgthjme6Bskl9LdpHtGH7j
         Ox42yh0ryVgR9kTDA1CtbRA/mQnGvqK00LuOT9KwdVhBmPrHZD4FTa9r7fX8vyg06Rvk
         +zjYkKdlsFEyy/6V6SexO8fiK3T6MDNnmVGV1FCmm3QVPwPCbF4SxWta5ZQRQcUUbmg1
         j7+A==
X-Forwarded-Encrypted: i=1; AJvYcCUjIXj6kNxKL0yCiQpq2mbsWAxIZIA+0JilSkZ171g7M7pk8lSVQaom2mOUnjwlsigzyzWXMh4O9E+LFioY@vger.kernel.org, AJvYcCWtFaSY7VyCEBd35PKqndi+LB/iAsEu3ek3lhNgDfUy3raiHPYAlIIPHblY4t+qnLoqz3XYNdIHjQE6@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7QdqdxPrR3xflgVSNeX/SShS5KEng9vafdlb5sTgL0tDGcFX
	J2AuJRicj1SKplZ/KfEWsH7+nhyki77xvd10N2sKfXtD0d5g5J28fTGeyGVR/QY=
X-Gm-Gg: ASbGncvchyrQ3+896qHz/ZhMmMUNRR4pQ+JG38hXMHisW3YUupjNbiRcbERSLQaQypO
	bVkdPwAzq8zYqQZem+7C/dDWOh9A5lNzOg0hMjstsp6pjmy19Y8+dMkRR3RU+TEIZSXOMMzEOFY
	fjiDJoA2t9td0NYnM/9Ej8q5fcFzaBbPpRqeqas/VnTMt2Qd760ZPAf6A82OWCkPdqXJtmSrvTI
	hHiyzuy4VUlGjIpWBXAcsBtMrckEP5cur3iPTch7ARP8oJtgPnrUZmgOrkYd81/OtyAVLs+Ka6O
	yOhqrjuh/QZc1ZXQTFL1zrm+uTL/EpKiTYqHnm1RSqGk
X-Google-Smtp-Source: AGHT+IEr8VZKlZ7IIYPgxyNWlJEzXndX2BwR3FYtz6od+rPLp6bFG9RsHZn/yoO5kSnu/NpReCNkfg==
X-Received: by 2002:a17:907:3e1b:b0:ac7:7d43:4535 with SMTP id a640c23a62f3a-ac7d6927509mr133733566b.0.1743755074851;
        Fri, 04 Apr 2025 01:24:34 -0700 (PDT)
Received: from localhost ([95.85.21.12])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7c0186250sm209973366b.155.2025.04.04.01.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 01:24:33 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:24:26 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ACPI: apply ACPI_NONSTRING annotations
Message-ID: <cover.1743754416.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Mark ACPI_COPY_NAMESEG() destination char arrays with the
ACPI_NONSTRING attribute.

This series depends on an upstream ACPICA commit[1].

[1] https://github.com/acpica/acpica/commit/de1d500509d37

Ahmed Salem (2):
  ACPI: PRM: apply ACPI_NONSTRING annotation
  ACPI: sysfs: apply ACPI_NONSTRING annotation

 drivers/acpi/prmt.c  | 2 +-
 drivers/acpi/sysfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: b3c623b9a94f7f798715c87e7a75ceeecf15292f
-- 
2.47.2


