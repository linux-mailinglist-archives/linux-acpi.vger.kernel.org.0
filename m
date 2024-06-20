Return-Path: <linux-acpi+bounces-6536-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D76590FAC2
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 03:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3DD2830BA
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8EB66F;
	Thu, 20 Jun 2024 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="I5RqrGVT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF9DDB8
	for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718845531; cv=none; b=YRb9l2BQ+UhzVvTLuf9aa0/2JB+4nM/GHJ3vmg19onEut8C0zMnBIzRWbyj6OtLef7E7oHOQasjGkiw99P8B1rYd7UHfHCaqUHWysLr2WZujYL5rHUgx+pweYtp33W9MAm1ngKSisSqJ0qv2qDaxKUYQID3i8gpE2Qf1hTkBFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718845531; c=relaxed/simple;
	bh=o+AtFRKSppPVchIcAIk8QIOiTYfGveuSXbYBE9byyqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpIRj2OP24Qc4ccyC82+ZeQHBYxoIwNuJl2V8XEIfp4RloRwYstHJAFt8h22KCdtndShP79Mg+iolAf2DWv4vhY5Yp59CA0A/04m4GxcO+5QBpvMizL/swniawsMtBPHCL7n+q5JT9WlLpvy5uzJ3X5Zm29ukDRWL8l/BYJx3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=I5RqrGVT; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7ebe019b9cdso10966839f.0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jun 2024 18:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718845529; x=1719450329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbSKc+TrggUrHTort2/p62nHWU+tnCEwH+LIOaDUnMY=;
        b=I5RqrGVTQ1jV9PG8nwDy0sX5HXJia0KHbPxH1S8jzy4Q11HkoMx9CTZTtwHWnXKD/y
         tfG5x18ua3/HXERRb13rzw7j+BYBtHQGgKuxHHfdlnLMPSpveqAN6UfKU/5gW73E14Na
         dT9lpmGBfnYh+VWkf9lILUWvzeqq7WAy0gPruWl8JKULQhAk2upS9vvyTmzaUJMXtZx1
         6RqUu16tYoKM+gUIrys8LB/aCBfz4Kjc71Ui/MYCUmYYTuJ2DeTmxepMYMxpvQumVDC0
         V+UIVA8LqPrSvtGP/HYxaNE4M5CeFtrRMKyYVjUBmNw/XxSJGxVLnU+u6utOn++OtdWk
         Tetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718845529; x=1719450329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbSKc+TrggUrHTort2/p62nHWU+tnCEwH+LIOaDUnMY=;
        b=qyty1LOOxHtkiv62q15JxRJV9QyR89dKejQp98fqMCk3CjzH6muc+NUCj2A6i4tVi6
         JZQmlHtQrU/fruymOCWCDlUSWsNpCPKWCNqWSNquDbXnSvAcrcaAMtplcfWVkRi2md8N
         z+YhAcT5q9wj/kDlK6Il4nI0Kx3poejiPR3y6h1118/rnvQWFN4Ei+QRZes6AIAF9S6N
         XqSoRreNX0eq00nJwfcgteN8mDMbMUkF19wARdeV0kKCzFmm5VgZ0lEUDF2f4OUptts9
         lnuWwI7KUJOvOWcSPoekT+IAACdbBP0WnXB7Lf/qGlygnvKMw4nDnNKf3VA02UgaoqcV
         RuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp9+YhCMTBXdSz9tzPJpyNPnrgDmUz1XdCdM8iaiV9pDxor4i1ivk3lm5J2uPFoZWV9YH4+4x6DbA5yOsthxWiizsMce2GBmQkbg==
X-Gm-Message-State: AOJu0YzG9iXKc9XvrwW3K81dr/uYzPAXBdFfq/o74hA39sVP6by2D90y
	Mk/3z9CeOFfJ+dSlZECFZUW5FhheM2UvQODMRE2VE2843XKXcJLvcwEqaeaqubc=
X-Google-Smtp-Source: AGHT+IFWukuy+yK0xWq0jQOureLprn4ZulWF8/CzRIJtzl9V0bK6pRZbTWtBrXeLa/MkYQC02Cg15g==
X-Received: by 2002:a05:6602:6b84:b0:7eb:687f:66a5 with SMTP id ca18e2360f4ac-7f13ee8fc06mr435515539f.21.1718845529168;
        Wed, 19 Jun 2024 18:05:29 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:212e:5310:572e:1126])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ebdb74cd1asm358910539f.0.2024.06.19.18.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 18:05:28 -0700 (PDT)
Date: Wed, 19 Jun 2024 20:05:25 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnOAVWdBanvocb4D@kf-XE>
References: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnJfmUXmU_tsb9pV@kf-XE>
 <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
 <12457165.O9o76ZdvQC@rjwysocki.net>
 <ZnNQF0ussBRSAt1g@kf-XE>
 <ZnNZgxDaXoCqkkJq@kf-XE>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnNZgxDaXoCqkkJq@kf-XE>

OK, we have done thorough benchmarking of the two patches. In summary,
they both seem to provide exactly the same performance improvements.
My initial worry that Rafael's patch didn't deliver the same performance
improvements was unfounded.

The following are the single-core and multi-core scores from running
Geekbench 5 multiple times on a Carbon Systems Iridium 16 system. The
first batch of tests was done with an Ubuntu kernel built with with my V3
proposed patch, while the second batch was done with a kernel build with
Rafael's proposed patch.

Links to the Geekbench 5 reports can be shared if needed.

_OSC CPPC bit ignore patch (written by Aaron Rainbolt):
Kernel parameter 'ignore_osc_cppc_bit' set in
'/etc/default/grub.d/kfocus.cfg'.
'/sys/devices/system/cpu/cpu*/acpi_cppc' and
'/proc/sys/kernel/sched_itmt_enabled' both present

| Run | Single | Multi  |
| --- | ------ | ------ |
|  01 |   1874 |  10475 |
|  02 |   1831 |  10132 |
|  03 |   1858 |  10348 |
|  04 |   1848 |  10370 |
|  05 |   1831 |  10413 |
| --- | ------ | ------ |
| AVG |   1848 |  10348 |


intel_pstate CPPC override patch (written by Rafael Wysocki):
No special kernel parameters set.
'/sys/devices/system/cpu/cpu*/acpi_cppc' ABSENT,
'/proc/sys/kernel/sched_itmt_enabled' present

| Run | Single | Multi  |
| --- | ------ | ------ |
|  01 |   1820 |  10310 |
|  02 |   1870 |  10303 |
|  03 |   1867 |  10420 |
|  04 |   1844 |  10283 |
|  05 |   1835 |  10451 |
| --- | ------ | ------ |
| AVG |   1847 |  10353 |

