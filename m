Return-Path: <linux-acpi+bounces-588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F737C5056
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 12:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E1C280CF0
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42431095B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Oct 2023 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NL6QxtAg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3C19BA7
	for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2023 09:03:01 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A30E318D;
	Wed, 11 Oct 2023 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:
	Content-Type; bh=0jNi8U0mUQ8Jvj+6Kfzg0hciRKTuXgh9miGP26ylKdQ=;
	b=NL6QxtAg8IEDwOnZRYQPZqx9JoA5nHPvBuWllx7/hAmSgA5Fl1X618AwRdj90o
	YDfiDZq2SK4y9p0zpyLfbautqnZnPQQyHE64VvJRo4v+T+tr4QMgTIe28FvWQX60
	JOhn679chyvwe5uhHqGVsJFhuv3dNmrQjsX2CfAJG1HYs=
Received: from [172.20.10.2] (unknown [39.144.139.13])
	by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wDnT+4vYSZlsnwHAQ--.40491S3;
	Wed, 11 Oct 2023 16:47:44 +0800 (CST)
Message-ID: <bdcf5da0-6618-b01c-40cd-a8be3181c322@163.com>
Date: Wed, 11 Oct 2023 16:47:42 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: linux-watchdog@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Wu, Xing Tong" <XingTong.Wu@siemens.com>, jan.kiszka@siemens.com,
 tobias.schaffner@siemens.com, cedric.hombourger@siemens.com,
 gerd.haeussler.ext@siemens.com
From: "xingtong.wu" <xingtong_wu@163.com>
Subject: [v2] wdat_wdt: Problem with WDAT using shared registers
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnT+4vYSZlsnwHAQ--.40491S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF47Zry5Gr4DXw4DArW7CFg_yoW8WFWxpa
	y5CrWjkrWvgr48uF4UXw1UCayruFW7JFW5Ar4xAw1Y9FWYkFWF9F9IyF1Fqa4DJr97WF1Y
	9F90qr1rA3yDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYsjUUUUUU=
X-Originating-IP: [39.144.139.13]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiTBMG0GI0bdQingAAsa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

change since v1:
 The time of the last email was wrong, correct the time in v2.

Hi

I want to use the wdat_wdt to support a watchdog of SIONCT (a multi-function device
(mfd)), and I register instructions for wdat_wdt in BIOS, it need registers 0x2e-0x2f
to access the watchdog, then register 0x2e-0x2f will be forever occupied by platform
device wdat_wdt, see the code: https://elixir.bootlin.com/linux/v6.6-rc5/source/drivers/acpi/acpi_watchdog.c#L180

but the 0x2e-0x2f are special, they are used for a multi-function device --SIONCT, the
device have many pins can not only support features for watchdog, but also other
features like leds, fans, temperature monitor... there are drivers for these pins, e.g.
gpio-f7188x, nct6775, w83627hf... these driver use the shared register 0x2e-0x2f. 

So the issue happened, the wdat_wdt occupied the shared register 0x2e-0x2f, then
the other driver can not load.

Here is the msg I collected from my device:

root@ipc-SIMATIC-IPC-BX-21A:/home/ipc# cat /proc/ioports 
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  002e-002e : wdat_wdt
  002f-002f : wdat_wdt

It will cause other SIONCT drivers can not load, e.g.
root@ipc-SIMATIC-IPC-BX-21A:/home/ipc# modprobe gpio-f7188x
modprobe: ERROR: could not insert 'gpio_f7188x': No such device

And dmesg info is:
[  213.559168] gpio-f7188xI/O address 0x002e already in use

Same reason for other drivers:
root@ipc-SIMATIC-IPC-BX-21A:/home/ipc# modprobe nct6775
modprobe: ERROR: could not insert 'nct6775': No such device

Do you have any idea for the wdat_wdt to add support for multi-function device?

BRS
Xing Tong Wu


