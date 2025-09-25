Return-Path: <linux-acpi+bounces-17307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBABBA06D3
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 17:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9886E4A568A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A972FFFBE;
	Thu, 25 Sep 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYG6YoVr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44231234973;
	Thu, 25 Sep 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815283; cv=none; b=bfpR51njg6u0Z1ymFWyNVQ6WGbZ2dqhJC/uQXh87i01YQxqXlyUgPt6oMliBcVpYo8+x4y9UiyMDd+qGLPq3doz6D+/lvd0xD1C7a8u3IxPU7rpkN0H1VULQUTuRuxRpULzk9F8osVl54b/M/Mn/qQW4srEPlcQcjKEXHiX0NXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815283; c=relaxed/simple;
	bh=wOTmxGtsrYB00Xp5bvu1cK9MEesyYzBVRKQiLZrnjHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVaJXXYoXxSErXNMEAJILS6xkz7ZSa9emIPMzkhHs2bYAcmsfXUTW7mfbBTLzQAkXWHbSxkFzZaBJvFsjr4V+B+EKFDN9IwsGASLJeZtPAUpgwuOqzJ8CRI3Yns6eZ0LdSv61zhUsZThELfNniZkmzkVesoNXxEjqI5yycQMPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYG6YoVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E78CC4CEF0;
	Thu, 25 Sep 2025 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758815281;
	bh=wOTmxGtsrYB00Xp5bvu1cK9MEesyYzBVRKQiLZrnjHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYG6YoVrAPVV9YhwxVY2jNwS95/9QPjXF2DtoB0yh04iQAkHtDdc58D/SngLNhBV/
	 4kzm6EiYRX1ObHBWY+fmGtwNz2KEsIjzDWmZSIZaMHpbPltDDQjXJETCom+jSOBsKL
	 ogHzr3o+X1u0bVNVu2Kq83+nO9wGZrmu5tVN5X9wfHDnVs6NsY50oL+rup5W+z0MKa
	 jineUIkhTTundrxOa9fO2M2tObs9dO08UOJLaxOrfcxBqhX/k/rPbhJN0CY3ZYbcbw
	 3eJptOfgOwuq55tENbrCkkimeTpjOpwIJP562O52rOygB/yzrQRjWzmcSeMkbNoLX1
	 WxWVa6gDa4rBQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Prashanth Prakash <pprakash@codeaurora.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v1 4/4] cpufreq: Drop unused symbol CPUFREQ_ETERNAL
Date: Thu, 25 Sep 2025 17:47:27 +0200
Message-ID: <9533136.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <8605612.T7Z3S40VBb@rafael.j.wysocki>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop CPUFREQ_ETERNAL that has no users any more along with all
references to it in the documentation.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 Documentation/admin-guide/pm/cpufreq.rst                  |    4 ----
 Documentation/cpu-freq/cpu-drivers.rst                    |    3 +--
 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst |    3 +--
 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst |    3 +--
 include/linux/cpufreq.h                                   |    5 -----
 5 files changed, 3 insertions(+), 15 deletions(-)

=2D-- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -274,10 +274,6 @@ are the following:
 	The time it takes to switch the CPUs belonging to this policy from one
 	P-state to another, in nanoseconds.
=20
=2D	If unknown or if known to be so high that the scaling driver does not
=2D	work with the `ondemand`_ governor, -1 (:c:macro:`CPUFREQ_ETERNAL`)
=2D	will be returned by reads from this attribute.
=2D
 ``related_cpus``
 	List of all (online and offline) CPUs belonging to this policy.
=20
=2D-- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -109,8 +109,7 @@ Then, the driver must fill in the follow
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cpuinfo.transition_latency | the time it takes on this CPU to	   |
 |				    | switch between two frequencies in	   |
=2D|				    | nanoseconds (if appropriate, else	   |
=2D|				    | specify CPUFREQ_ETERNAL)		   |
+|				    | nanoseconds                          |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cur			    | The current operating frequency of   |
 |				    | this CPU (if appropriate)		   |
=2D-- a/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst
@@ -112,8 +112,7 @@ CPUfreq=E6=A0=B8=E5=BF=83=E5=B1=82=E6=B3=A8=E5=86=8C=E4=
=B8=80=E4=B8=AAcpufreq_driv
 |                                   |                                     =
 |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cpuinfo.transition_latency | CPU=E5=9C=A8=E4=B8=A4=E4=B8=AA=E9=A2=
=91=E7=8E=87=E4=B9=8B=E9=97=B4=E5=88=87=E6=8D=A2=E6=89=80=E9=9C=80=E7=9A=84=
=E6=97=B6=E9=97=B4=EF=BC=8C=E4=BB=A5  |
=2D|                                   | =E7=BA=B3=E7=A7=92=E4=B8=BA=E5=8D=
=95=E4=BD=8D=EF=BC=88=E5=A6=82=E4=B8=8D=E9=80=82=E7=94=A8=EF=BC=8C=E8=AE=BE=
=E5=AE=9A=E4=B8=BA         |
=2D|                                   | CPUFREQ_ETERNAL=EF=BC=89          =
          |
+|                                   | =E7=BA=B3=E7=A7=92=E4=B8=BA=E5=8D=95=
=E4=BD=8D                    |
 |                                   |                                     =
 |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cur                        | =E8=AF=A5CPU=E5=BD=93=E5=89=8D=E7=9A=
=84=E5=B7=A5=E4=BD=9C=E9=A2=91=E7=8E=87(=E5=A6=82=E9=80=82=E7=94=A8)       =
   |
=2D-- a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
@@ -112,8 +112,7 @@ CPUfreq=E6=A0=B8=E5=BF=83=E5=B1=A4=E8=A8=BB=E5=86=8A=E4=
=B8=80=E5=80=8Bcpufreq_driv
 |                                   |                                     =
 |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cpuinfo.transition_latency | CPU=E5=9C=A8=E5=85=A9=E5=80=8B=E9=A0=
=BB=E7=8E=87=E4=B9=8B=E9=96=93=E5=88=87=E6=8F=9B=E6=89=80=E9=9C=80=E7=9A=84=
=E6=99=82=E9=96=93=EF=BC=8C=E4=BB=A5  |
=2D|                                   | =E7=B4=8D=E7=A7=92=E7=88=B2=E5=96=
=AE=E4=BD=8D=EF=BC=88=E5=A6=82=E4=B8=8D=E9=81=A9=E7=94=A8=EF=BC=8C=E8=A8=AD=
=E5=AE=9A=E7=88=B2         |
=2D|                                   | CPUFREQ_ETERNAL=EF=BC=89          =
          |
+|                                   | =E7=B4=8D=E7=A7=92=E7=88=B2=E5=96=AE=
=E4=BD=8D                    |
 |                                   |                                     =
 |
 +-----------------------------------+-------------------------------------=
=2D+
 |policy->cur                        | =E8=A9=B2CPU=E7=95=B6=E5=89=8D=E7=9A=
=84=E5=B7=A5=E4=BD=9C=E9=A0=BB=E7=8E=87(=E5=A6=82=E9=81=A9=E7=94=A8)       =
   |
=2D-- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -26,13 +26,8 @@
  *********************************************************************/
 /*
  * Frequency values here are CPU kHz
=2D *
=2D * Maximum transition latency is in nanoseconds - if it's unknown,
=2D * CPUFREQ_ETERNAL shall be used.
  */
=20
=2D#define CPUFREQ_ETERNAL			(-1)
=2D
 #define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS	NSEC_PER_MSEC
=20
 #define CPUFREQ_NAME_LEN		16




