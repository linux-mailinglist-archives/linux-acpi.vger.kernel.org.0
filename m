Return-Path: <linux-acpi+bounces-555-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D247BF1F2
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 06:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F921C20A71
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB65259D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D515AE
	for <linux-acpi@vger.kernel.org>; Tue, 10 Oct 2023 03:37:55 +0000 (UTC)
Received: from jari.cn (unknown [218.92.28.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1666A9E;
	Mon,  9 Oct 2023 20:37:52 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Tue, 10 Oct 2023 11:36:04
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date: Tue, 10 Oct 2023 11:36:04 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: chenguohua@jari.cn
To: rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux: Clean up errors in hil.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <230de0eb.8f4.18b17a7f26a.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwD3lD+kxiRlPuXAAA--.712W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwA5sq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBH
dW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBpbmNsdWRlL2xpbnV4L2hpbC5o
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9oaWwuaCBiL2luY2x1ZGUvbGludXgvaGlsLmgKaW5k
ZXggNTIzNzg1YTlkZTcwLi45YTE1MWUwMWU2NjIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgv
aGlsLmgKKysrIGIvaW5jbHVkZS9saW51eC9oaWwuaApAQCAtNDM5LDcgKzQzOSw3IEBAIGVudW0g
aGlsX2NvbW1hbmQgewogICBLRVlfRU5URVIsCUtFWV9MRUZUQ1RSTCwJS0VZX0EsCQlLRVlfUywJ
CQlcCiAgIEtFWV9ELAlLRVlfRiwJCUtFWV9HLAkJS0VZX0gsCQkJXAogICBLRVlfSiwJS0VZX0ss
CQlLRVlfTCwJCUtFWV9TRU1JQ09MT04sCQlcCi0gIEtFWV9BUE9TVFJPUEhFLEtFWV9HUkFWRSwJ
S0VZX0xFRlRTSElGVCwJS0VZX0JBQ0tTTEFTSCwJCVwKKyAgS0VZX0FQT1NUUk9QSEUsIEtFWV9H
UkFWRSwJS0VZX0xFRlRTSElGVCwJS0VZX0JBQ0tTTEFTSCwJCVwKICAgS0VZX1osCUtFWV9YLAkJ
S0VZX0MsCQlLRVlfViwJCQlcCiAgIEtFWV9CLAlLRVlfTiwJCUtFWV9NLAkJS0VZX0NPTU1BLAkJ
XAogICBLRVlfRE9ULAlLRVlfU0xBU0gsCUtFWV9SSUdIVFNISUZULAlLRVlfS1BBU1RFUklTSywJ
CVwKLS0gCjIuMTcuMQo=

