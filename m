Return-Path: <linux-acpi+bounces-20904-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cISLDJyziWkUBAUAu9opvQ
	(envelope-from <linux-acpi+bounces-20904-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 11:14:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51E10E0A6
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AC3C3006101
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Feb 2026 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7EB366075;
	Mon,  9 Feb 2026 10:14:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2EE308F05;
	Mon,  9 Feb 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632090; cv=none; b=W1LV5PJ23XX4AbQOHOJVk+DJmFa6i7cudZSJV/GvSgkf2ajcs3XtRmHCD+9T1w8cFJmKT6bUADqaLaBK4/E7fQaHBBx7Gp22f0vXa8txgODGDX+H8qKYEpbhdflqzF33g2KxiD2sQ+uwO2JRnb0BMSCFQ0RnziVheFptqJCSUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632090; c=relaxed/simple;
	bh=Ta/VVUsj0jlGYnAYKXVuMgm27SvKAKIxZN6Ip4o2U+M=;
	h=Message-Id:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJFDksZMpyS10eAND3+/4rM1ebTdJN+wiJ9saIxe5+gN8P9CqjcdMT9iEoh7g7M7drSCRHvLSUdk1PvhLzs8nbr/KtiEwHDbzIZgb4MqvqOCcxNu+P/pXsz/4iugVEj9xY6YubmJcguRwt1XhXROm64kJc3ZDVPORTO1CyRtRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4f8gY26qY6z8Xs71;
	Mon, 09 Feb 2026 18:14:46 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4f8gXq59RBz4xQXF;
	Mon, 09 Feb 2026 18:14:35 +0800 (CST)
Received: (from root@localhost)
	by mse-fl1.zte.com.cn id 619AEZcC084692;
	Mon, 9 Feb 2026 18:14:35 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202602091014.619AEZcC084692@mse-fl1.zte.com.cn>
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 619A7uLN077329;
	Mon, 9 Feb 2026 18:07:56 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from localhost.localdomain (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Mon, 9 Feb 2026 18:07:59 +0800
X-Zmail-TransId: 3e816989b1d3001-f75c0
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: fustini@kernel.org
Cc: gong.shuai@sanechips.com.cn, Dave.Martin@arm.com,
        acpica-devel@lists.linux.dev, alex@ghiti.fr, aou@eecs.berkeley.edu,
        aricciardi@baylibre.com, atish.patra@linux.dev, atishp@rivosinc.com,
        babu.moger@amd.com, ben.horgan@arm.com, conor+dt@kernel.org,
        cp0613@linux.alibaba.com, cuiyunhui@bytedance.com,
        devicetree@vger.kernel.org, fenghua.yu@intel.com,
        guo.wenjia23@zte.com.cn, james.morse@arm.com, krzk+dt@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        liu.qingtao2@zte.com.cn, liwei1518@gmail.com, mindal@semihalf.com,
        npitre@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        peternewman@google.com, pjw@kernel.org, rafael@kernel.org,
        reinette.chatre@intel.com, rkrcmar@ventanamicro.com,
        robert.moore@intel.com, robh@kernel.org, samuel.holland@sifive.com,
        sunilvl@ventanamicro.com, tony.luck@intel.com, vasu@rivosinc.com,
        ved@rivosinc.com, x86@kernel.org, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl interface for CBQRI controllers
Date: Mon,  9 Feb 2026 18:07:15 +0800
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
References: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: true
Content-Transfer-Encoding: 8bit
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL:mse-fl1.zte.com.cn 619AEZcC084692
X-MSS: AUDITRELEASE@mse-fl1.zte.com.cn
X-TLS: YES
X-SPF-DOMAIN: sanechips.com.cn
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SPF: None
X-SOURCE-IP: 192.168.251.13 unknown Mon, 09 Feb 2026 18:14:46 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6989B396.002/4f8gY26qY6z8Xs71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/related,multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20904-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[8];
	DMARC_NA(0.00)[sanechips.com.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sanechips.com.cn,arm.com,lists.linux.dev,ghiti.fr,eecs.berkeley.edu,baylibre.com,linux.dev,rivosinc.com,amd.com,kernel.org,linux.alibaba.com,bytedance.com,vger.kernel.org,intel.com,zte.com.cn,lists.infradead.org,gmail.com,semihalf.com,dabbelt.com,sifive.com,google.com,ventanamicro.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[43];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gong.shuai@sanechips.com.cn,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE51E10E0A6
X-Rspamd-Action: no action



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGksIERyZXcNCg0KPiBBZGQgaW50ZXJmYWNlIGZvciBDQlFSSSBjb250cm9sbGVyIGRyaXZlcnMg
dG8gbWFrZSB1c2Ugb2YgdGhlIHJlc2N0cmwNCj4gZmlsZXN5c3RlbS4NCj4gDQo+IENvLWRldmVs
b3BlZC1ieTogQWRyaWVuIFJpY2NpYXJkaSA8YXJpY2NpYXJkaUBiYXlsaWJyZS5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEFkcmllbiBSaWNjaWFyZGkgPGFyaWNjaWFyZGlAYmF5bGlicmUuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBEcmV3IEZ1c3RpbmkgPGZ1c3RpbmlAa2VybmVsLm9yZz4NCj4gLS0t
DQo+DQo+IC4uLg0KPg0KPiArdTMyIHJlc2N0cmxfYXJjaF9nZXRfY29uZmlnKHN0cnVjdCByZHRf
cmVzb3VyY2UgKnIsIHN0cnVjdCByZHRfY3RybF9kb21haW4gKmQsDQo+ICsJCQkgICAgdTMyIGNs
b3NpZCwgZW51bSByZXNjdHJsX2NvbmZfdHlwZSB0eXBlKQ0KPiArew0KPiArCXN0cnVjdCBjYnFy
aV9yZXNjdHJsX2RvbSAqaHdfZG9tOw0KPiArCXN0cnVjdCBjYnFyaV9jb250cm9sbGVyICpjdHJs
Ow0KPiArCWludCByZWdfb2Zmc2V0Ow0KPiArCXUzMiBwZXJjZW50Ow0KPiArCXUzMiByYndiOw0K
PiArCXU2NCByZWc7DQo+ICsJaW50IGVycjsNCj4gKw0KPiArCWh3X2RvbSA9IGNvbnRhaW5lcl9v
ZihkLCBzdHJ1Y3QgY2JxcmlfcmVzY3RybF9kb20sIHJlc2N0cmxfY3RybF9kb20pOw0KPiArDQo+
ICsJY3RybCA9IGh3X2RvbS0+aHdfY3RybDsNCj4gKw0KPiArCWlmICghci0+YWxsb2NfY2FwYWJs
ZSkNCj4gKwkJcmV0dXJuIHJlc2N0cmxfZ2V0X2RlZmF1bHRfY3RybChyKTsNCj4gKw0KPiArCXN3
aXRjaCAoci0+cmlkKSB7DQo+ICsJY2FzZSBSRFRfUkVTT1VSQ0VfTDI6DQo+ICsJY2FzZSBSRFRf
UkVTT1VSQ0VfTDM6DQo+ICsJCS8qIENsZWFyIGNjX2Jsb2NrX21hc2sgYmVmb3JlIHJlYWQgbGlt
aXQgb3BlcmF0aW9uICovDQo+ICsJCWNicXJpX3NldF9jYm0oY3RybCwgMCk7DQo+ICsNCj4gKwkJ
LyogQ2FwYWNpdHkgcmVhZCBsaW1pdCBvcGVyYXRpb24gZm9yIFJDSUQgKGNsb3NpZCkgKi8NCj4g
KwkJZXJyID0gY2JxcmlfY2NfYWxsb2Nfb3AoY3RybCwgQ0JRUklfQ0NfQUxMT0NfQ1RMX09QX1JF
QURfTElNSVQsIHR5cGUsIGNsb3NpZCk7DQoNCkl0IGxvb2tzIGxpa2UgdGhlIHBhcmFtZXRlciBv
cmRlciBtaWdodCBiZSBpbmNvcnJlY3QuIEkgYmVsaWV2ZSBpdCBzaG91bGQgYmU6DQpjYnFyaV9j
Y19hbGxvY19vcChjdHJsLCBDQlFSSV9DQ19BTExPQ19DVExfT1BfUkVBRF9MSU1JVCwgY2xvc2lk
LCB0eXBlKQ0KDQpDb3VsZCB5b3UgcGxlYXNlIGRvdWJsZS1jaGVjaz8NCg0KPiArCQlpZiAoZXJy
IDwgMCkgew0KPiArCQkJcHJfZXJyKCIlcygpOiBvcGVyYXRpb24gZmFpbGVkOiBlcnIgPSAlZCIs
IF9fZnVuY19fLCBlcnIpOw0KPiArCQkJcmV0dXJuIHJlc2N0cmxfZ2V0X2RlZmF1bHRfY3RybChy
KTsNCj4gKwkJfQ0KPiAuLi4NCg0KVGhhbmtzLA0KU2h1YWk=


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGksJm5ic3A7RHJldzxiciAvPg08YnIgLz4mZ3Q7Jm5ic3A7QWRkJm5ic3A7aW50ZXJmYWNlJm5i
c3A7Zm9yJm5ic3A7Q0JRUkkmbmJzcDtjb250cm9sbGVyJm5ic3A7ZHJpdmVycyZuYnNwO3RvJm5i
c3A7bWFrZSZuYnNwO3VzZSZuYnNwO29mJm5ic3A7dGhlJm5ic3A7cmVzY3RybDxiciAvPiZndDsm
bmJzcDtmaWxlc3lzdGVtLjxiciAvPiZndDsmbmJzcDsNPGJyIC8+Jmd0OyZuYnNwO0NvLWRldmVs
b3BlZC1ieTombmJzcDtBZHJpZW4mbmJzcDtSaWNjaWFyZGkmbmJzcDsmbHQ7YXJpY2NpYXJkaUBi
YXlsaWJyZS5jb20mZ3Q7DTxiciAvPiZndDsmbmJzcDtTaWduZWQtb2ZmLWJ5OiZuYnNwO0Fkcmll
biZuYnNwO1JpY2NpYXJkaSZuYnNwOyZsdDthcmljY2lhcmRpQGJheWxpYnJlLmNvbSZndDsNPGJy
IC8+Jmd0OyZuYnNwO1NpZ25lZC1vZmYtYnk6Jm5ic3A7RHJldyZuYnNwO0Z1c3RpbmkmbmJzcDsm
bHQ7ZnVzdGluaUBrZXJuZWwub3JnJmd0Ow08YnIgLz4mZ3Q7Jm5ic3A7LS0tPGJyIC8+Jmd0Ow08
YnIgLz4mZ3Q7Jm5ic3A7Li4uPGJyIC8+Jmd0Ow08YnIgLz4mZ3Q7Jm5ic3A7K3UzMiZuYnNwO3Jl
c2N0cmxfYXJjaF9nZXRfY29uZmlnKHN0cnVjdCZuYnNwO3JkdF9yZXNvdXJjZSZuYnNwOypyLCZu
YnNwO3N0cnVjdCZuYnNwO3JkdF9jdHJsX2RvbWFpbiZuYnNwOypkLDxiciAvPiZndDsmbmJzcDsr
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7dTMyJm5ic3A7Y2xvc2lkLCZu
YnNwO2VudW0mbmJzcDtyZXNjdHJsX2NvbmZfdHlwZSZuYnNwO3R5cGUpPGJyIC8+Jmd0OyZuYnNw
Oyt7PGJyIC8+Jmd0OyZuYnNwOysmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtzdHJ1Y3QmbmJzcDtj
YnFyaV9yZXNjdHJsX2RvbSZuYnNwOypod19kb207PGJyIC8+Jmd0OyZuYnNwOysmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDtzdHJ1Y3QmbmJzcDtjYnFyaV9jb250cm9sbGVyJm5ic3A7KmN0cmw7PGJy
IC8+Jmd0OyZuYnNwOysmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtpbnQmbmJzcDtyZWdfb2Zmc2V0
OzxiciAvPiZndDsmbmJzcDsrJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7dTMyJm5ic3A7cGVyY2Vu
dDs8YnIgLz4mZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3UzMiZuYnNwO3Jid2I7
PGJyIC8+Jmd0OyZuYnNwOysmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt1NjQmbmJzcDtyZWc7PGJy
IC8+Jmd0OyZuYnNwOysmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtpbnQmbmJzcDtlcnI7PGJyIC8+
Jmd0OyZuYnNwOys8YnIgLz4mZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2h3X2Rv
bSZuYnNwOz0mbmJzcDtjb250YWluZXJfb2YoZCwmbmJzcDtzdHJ1Y3QmbmJzcDtjYnFyaV9yZXNj
dHJsX2RvbSwmbmJzcDtyZXNjdHJsX2N0cmxfZG9tKTs8YnIgLz4mZ3Q7Jm5ic3A7KzxiciAvPiZn
dDsmbmJzcDsrJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Y3RybCZuYnNwOz0mbmJzcDtod19kb20t
Jmd0O2h3X2N0cmw7PGJyIC8+Jmd0OyZuYnNwOys8YnIgLz4mZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwO2lmJm5ic3A7KCFyLSZndDthbGxvY19jYXBhYmxlKTxiciAvPiZndDsmbmJz
cDsrJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7cmV0dXJu
Jm5ic3A7cmVzY3RybF9nZXRfZGVmYXVsdF9jdHJsKHIpOzxiciAvPiZndDsmbmJzcDsrPGJyIC8+
Jmd0OyZuYnNwOysmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtzd2l0Y2gmbmJzcDsoci0mZ3Q7cmlk
KSZuYnNwO3s8YnIgLz4mZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2Nhc2UmbmJz
cDtSRFRfUkVTT1VSQ0VfTDI6PGJyIC8+Jmd0OyZuYnNwOysmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDtjYXNlJm5ic3A7UkRUX1JFU09VUkNFX0wzOjxiciAvPiZndDsmbmJzcDsrJm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7LyombmJzcDtDbGVhciZuYnNwO2Nj
X2Jsb2NrX21hc2smbmJzcDtiZWZvcmUmbmJzcDtyZWFkJm5ic3A7bGltaXQmbmJzcDtvcGVyYXRp
b24mbmJzcDsqLzxiciAvPiZndDsmbmJzcDsrJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Y2Jxcmlfc2V0X2NibShjdHJsLCZuYnNwOzApOzxiciAvPiZndDsm
bmJzcDsrPGJyIC8+Jmd0OyZuYnNwOysmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsvKiZuYnNwO0NhcGFjaXR5Jm5ic3A7cmVhZCZuYnNwO2xpbWl0Jm5ic3A7
b3BlcmF0aW9uJm5ic3A7Zm9yJm5ic3A7UkNJRCZuYnNwOyhjbG9zaWQpJm5ic3A7Ki88YnIgLz4m
Z3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
O2VyciZuYnNwOz0mbmJzcDtjYnFyaV9jY19hbGxvY19vcChjdHJsLCZuYnNwO0NCUVJJX0NDX0FM
TE9DX0NUTF9PUF9SRUFEX0xJTUlULCZuYnNwO3R5cGUsJm5ic3A7Y2xvc2lkKTs8YnIgLz4NPGJy
IC8+SXQmbmJzcDtsb29rcyZuYnNwO2xpa2UmbmJzcDt0aGUmbmJzcDtwYXJhbWV0ZXImbmJzcDtv
cmRlciZuYnNwO21pZ2h0Jm5ic3A7YmUmbmJzcDtpbmNvcnJlY3QuJm5ic3A7SSZuYnNwO2JlbGll
dmUmbmJzcDtpdCZuYnNwO3Nob3VsZCZuYnNwO2JlOjxiciAvPmNicXJpX2NjX2FsbG9jX29wKGN0
cmwsJm5ic3A7Q0JRUklfQ0NfQUxMT0NfQ1RMX09QX1JFQURfTElNSVQsJm5ic3A7Y2xvc2lkLCZu
YnNwO3R5cGUpPGJyIC8+DTxiciAvPkNvdWxkJm5ic3A7eW91Jm5ic3A7cGxlYXNlJm5ic3A7ZG91
YmxlLWNoZWNrPzxiciAvPg08YnIgLz4mZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2lmJm5ic3A7KGVyciZuYnNwOyZsdDsmbmJzcDswKSZu
YnNwO3s8YnIgLz4mZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3ByX2VycigmcXVvdDslcygpOiZu
YnNwO29wZXJhdGlvbiZuYnNwO2ZhaWxlZDombmJzcDtlcnImbmJzcDs9Jm5ic3A7JWQmcXVvdDss
Jm5ic3A7X19mdW5jX18sJm5ic3A7ZXJyKTs8YnIgLz4mZ3Q7Jm5ic3A7KyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
O3JldHVybiZuYnNwO3Jlc2N0cmxfZ2V0X2RlZmF1bHRfY3RybChyKTs8YnIgLz4mZ3Q7Jm5ic3A7
KyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO308YnIgLz4m
Z3Q7Jm5ic3A7Li4uPGJyIC8+DTxiciAvPlRoYW5rcyw8YnIgLz5TaHVhaQ==


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


