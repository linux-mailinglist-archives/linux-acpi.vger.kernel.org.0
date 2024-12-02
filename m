Return-Path: <linux-acpi+bounces-9877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF99E0680
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 16:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2152BB3F6A8
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4262208980;
	Mon,  2 Dec 2024 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="ETuPqeu/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F5204F9A;
	Mon,  2 Dec 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151170; cv=none; b=ILCOXTEK10Cnu3s+bij7D7kwROv63+j10g4WOhc7KxlXihttcNt0urp0lpmlJIEzUlsNdG97FfoXEwc3qSAXPMVNiCb6tRB1MkKdt3yt+/yNK1Cz+OTwzGpRPGqB2wLFkC1POh7ZNdum6KMQVWoVRBCqZUBii5TWnup1XX1fyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151170; c=relaxed/simple;
	bh=rT9VaR6v1mmYhp2ftQn0+mWQGeq2hvN4EOp198kLKo0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EEf6cjQ1GIH7DKcpUrDIIlJiugBvk1dW3aiyk8sY2gRUFsI1XNNfmdI+4TQ4x3Z/wyANm+og9VxUGgIpBs+uLMuCO2ZfDMXtiZcoOzWaI3wJOovcbQgeaE24Z2y2aDUF30VryeX58lk7O4ehphRDGnIO/w4qCeDkp2vrlcl72jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=ETuPqeu/; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.115] (pd9e59944.dip0.t-ipconnect.de [217.229.153.68])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 03F662FC0073;
	Mon,  2 Dec 2024 15:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1733151164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TxWSYF+tOsnTF953gnzQP7j7/YdmnY0WBVhb4C7tZRM=;
	b=ETuPqeu/zhRwzdLvAwzK0LEotakVa5H8wNDZMKWK4ovdpiZwdlPW3t9sYKKrAPKPiM95sn
	XYL9T/n09uhNGYVe94NL/EZk77p2yP+Av/RBGNFjuajUIHPS/3+3LuDn3ayBRXoANIPWtF
	aMEMsJWjsdPlGrYJT3dia382MwYJvdo=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com>
Date: Mon, 2 Dec 2024 15:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, Hans de Goede <hdegoede@redhat.com>,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
From: Werner Sembach <wse@tuxedocomputers.com>
Subject: Thermal driver with safeguards
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

given a pair of a temperature sensor and a fan, I want to implement a driver. 
that allows userspace to directly control the fan if it wants to. But have a 
minimum fan speed when certain high temperatures are reached to avoid crashes or 
hardware damage.

e.g.

- temperature of target die is 80°C -> fan speed must be at least 30%

- temperature of target die is 90°C -> fan speed must be at least 40%

- temperature of target die is 105°C -> fan speed must be 100%

- temperature of target die is 110°C -> device shuts off to protect the hardware

Would the thermal subsystem be the right place for this to implement this 
protection in driver?

It already has functions around periodic temperature polling and trip points.

Kind regards,

Werner Sembach


