Return-Path: <linux-acpi+bounces-21101-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAu+D5Q3nWlINQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21101-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:31:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B039181E80
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60623305B35B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 05:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06060296BB6;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdWzl9KP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FD19D074;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911052; cv=none; b=Tv08qGeIHxDUqD4/piFq+qm9gBSJmAQN4zOPGYqgo2oaPVVPjoFpZEfx3znPWDj54ciyBu+0UJrjaf90EXWaY5YLsq+et2OIYs4zuqe4J+xUh0fu/E5ps5AevHHymjLs200M4GT5xfFGuyt+6ETirjJrPqFvxFveW0jfIn2UWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911052; c=relaxed/simple;
	bh=ul9pqll2OSaIKRropAAhp3YOqELMgU3KZnuLR8PCb0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7TLUZGMxhovKzzHn9IwMV7LGvWqHrxymSu5Q1py6iO6e9r273nKCVZODR5eXnCNcsK9g6K/piSBqs6/3PBsRp9qTo+paRmhtGsCmm9MOF7+DnRyjqdx1wWF+136+6HjKFcRv6Eoyf814MXX3OTljsvHlq92jAIKhrpvlecQzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdWzl9KP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 721ACC19425;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771911052;
	bh=ul9pqll2OSaIKRropAAhp3YOqELMgU3KZnuLR8PCb0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YdWzl9KPmacS8e/maSekJ9XaWlO+lR0uvKwx/6PMQLrIuf0fIMi4PLpIYjeXpdPIy
	 QWklOd7Tcazy6l4See/1tXRXYWCIWiAQek4MEr/+1MuC6JVp5+6wVDqxg6Z7DL0T0q
	 fy+YbTS6gxE+fM7EH/ghe9xVP76g1IEZ+dKAMMd+RTUfB24WjdvBe5b28Q8swr0jiW
	 PLK57O+fal4/xEtYZuU+r9A3p+orw5zKogK9DyDnwX75dFEUn6Zsvb3d3EgNckXRAj
	 Iwx+hptqobYKB8LDK27rIkSxBPKiWExbJq1799Gnp0H/wZmWziG513PHE7cyygvH0z
	 yAsw0xRnnvaiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A65EFB7FA;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 24 Feb 2026 11:00:47 +0530
Subject: [PATCH v5 1/9] serdev: Convert to_serdev_*() helpers to macros and
 use container_of_const()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260224-pci-m2-e-v5-1-dd9b9501d33c@oss.qualcomm.com>
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
In-Reply-To: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=jiQzAn5Z8SWByOSZJxw8qqvki+Y9WdMaik55wmM6Ke4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpnTeI93TH6+tEvd+0lGzz/KDbf1ZKAlaOgT7rQ
 3XGIWgMl22JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaZ03iAAKCRBVnxHm/pHO
 9YlMB/sEV0/LChCElmZYkCcPOtVzX8Wx2gptYWufJFu9OUug4vW/7P80tz940dvDpX4W1k7IFyT
 dLP/IGHq5McgvmHyRHluS/LXsthANOmdnfYZ5Rs6PKusmP8ohPvKmTpCydTI07tJWv6ihg2ZfXr
 AA63zTmV9xKXQlizS5XC4U1szfT89Zl1iXbeRf7HnBL208OMfoD495Xs033jMgJhRzjE0sT0U+t
 0Aoflb2UKLSzvg8TepTI4LJ6+SVAe+0A/57ZMOv649s3rhEq8jQFFZfEs0ZpikoObxkjMgHfdWo
 VeeUEHn00jou/ZeF4YdJZjNUMXucbQq5s6O5sxN0nryjf7fb
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21101-lists,linux-acpi=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-acpi@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 7B039181E80
X-Rspamd-Action: no action

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If these helpers receive the 'const struct device' pointer, then the const
qualifier will get dropped, leading to below warning:

warning: passing argument 1 of ‘to_serdev_device_driver’ discards 'const'
qualifier from pointer target type [-Wdiscarded-qualifiers]

This is not an issue as of now, but with the future commits adding serdev
device based driver matching, this warning will get triggered. Hence,
convert these helpers to macros so that the qualifier get preserved and
also use container_of_const() as container_of() is deprecated.

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/linux/serdev.h | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 5654c58eb73c..0c7d3c27d1f8 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -49,10 +49,7 @@ struct serdev_device {
 	struct mutex write_lock;
 };
 
-static inline struct serdev_device *to_serdev_device(struct device *d)
-{
-	return container_of(d, struct serdev_device, dev);
-}
+#define to_serdev_device(d) container_of_const(d, struct serdev_device, dev)
 
 /**
  * struct serdev_device_driver - serdev slave device driver
@@ -68,10 +65,7 @@ struct serdev_device_driver {
 	void	(*shutdown)(struct serdev_device *);
 };
 
-static inline struct serdev_device_driver *to_serdev_device_driver(struct device_driver *d)
-{
-	return container_of(d, struct serdev_device_driver, driver);
-}
+#define to_serdev_device_driver(d) container_of_const(d, struct serdev_device_driver, driver)
 
 enum serdev_parity {
 	SERDEV_PARITY_NONE,
@@ -112,10 +106,7 @@ struct serdev_controller {
 	const struct serdev_controller_ops *ops;
 };
 
-static inline struct serdev_controller *to_serdev_controller(struct device *d)
-{
-	return container_of(d, struct serdev_controller, dev);
-}
+#define to_serdev_controller(d) container_of_const(d, struct serdev_controller, dev)
 
 static inline void *serdev_device_get_drvdata(const struct serdev_device *serdev)
 {

-- 
2.51.0



