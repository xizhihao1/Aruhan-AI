# Disclaimer, Acceptable Use & Legal Notice / 免责声明、可接受使用与法律提示

**Version / 版本：2.1.34** · [English](#english) · [中文](#中文)

> This document is a project notice, not legal advice. Use of the distributed
> software is subject to the terms published with each release.

---

## English

### 1. No warranty

THE SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS” AND “AS AVAILABLE”, WITHOUT
WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE,
NON-INFRINGEMENT, ACCURACY, AND QUIET ENJOYMENT. THE AUTHORS AND COPYRIGHT
HOLDERS DO NOT WARRANT THAT THE SOFTWARE WILL BE UNINTERRUPTED, ERROR-FREE,
SECURE, OR COMPATIBLE WITH ANY PARTICULAR SYSTEM OR PROVIDER.

### 2. Limitation of liability

TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THE AUTHORS, CONTRIBUTORS,
AND COPYRIGHT HOLDERS SHALL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, CONSEQUENTIAL, OR PUNITIVE DAMAGES, OR FOR ANY LOSS OF
PROFITS, REVENUE, DATA, GOODWILL, OR BUSINESS OPPORTUNITY, ARISING FROM OR
RELATED TO THE SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
THIS INCLUDES DAMAGES CAUSED BY AI OUTPUT, TOOL EXECUTION, MODEL PROVIDERS,
NETWORK FAILURES, CONFIGURATION ERRORS, OR DATA LOSS.

Some jurisdictions do not allow certain exclusions. In that case, the exclusions
apply to the maximum extent permitted by law.

### 3. AI output is not professional advice

Aruhan invokes third-party or self-hosted language and media models. Output may
be:

- incorrect, incomplete, outdated, biased, or offensive;
- insecure, non-compliant, or infringing;
- unsuitable for production without review;
- different across runs, models, providers, and settings.

You are responsible for reviewing, testing, and validating all output before
using it. AI output is **not** legal, medical, financial, tax, safety, or other
professional advice.

### 4. Tool execution and agentic behavior

Aruhan can read/write files, run commands, control terminals, call MCP tools,
automate browsers, and (where enabled) control the screen, keyboard, and mouse.
Risks include:

- destructive file or database operations;
- command injection and prompt injection from untrusted files, repositories,
  web pages, emails, issues, or tool output;
- credential or data exfiltration;
- unintended commits, pushes, deployments, or purchases;
- irreversible actions in production environments.

You must:

- use the least-privilege permission mode and sandbox scope;
- review tool calls and diffs before approving;
- avoid `auto`/`yolo`/`bypassPermissions` on untrusted content or production;
- keep backups and version control;
- isolate untrusted repositories (container/VM/separate user);
- test changes in non-production environments first.

### 5. Model providers, credentials, and costs

- You are responsible for obtaining lawful access to every provider you
  configure and for complying with that provider's terms, acceptable-use policy,
  rate limits, and data-processing terms.
- API keys and other credentials are your responsibility. Store them securely,
  rotate them, and do not commit or share them.
- Provider charges, quotas, and billing are between you and the provider.
  Aruhan does not control provider pricing, availability, or model behavior.
- Requests go to the Base URL you configure. If you point Aruhan at a
  third-party gateway, that gateway may log or retain your data.
- `aruhan.json` encryption is machine-bound. Copying it to another machine does
  not transfer usable keys.

### 6. Privacy and data handling

- Aruhan is local-first: configuration, sessions, memory, and logs are stored
  on your machine (or the data directory you choose).
- Prompts, file contents, tool output, and generated code may be sent to the
  model provider you configure. Do not send personal, confidential, regulated,
  or export-controlled data unless you are authorized and the provider's terms
  permit it.
- Logs and diagnostic bundles may contain prompts, paths, file names, and model
  metadata. Redaction is best-effort; review before sharing.
- Third-party providers, MCP servers, plugins, hooks, and gateways have their
  own data practices. Review them before use.
- Observability telemetry is disabled by default. If a deployment sets
  `ARUHAN_TELEMETRY_ENABLED=true` and configures
  `ARUHAN_TELEMETRY_OTLP_ENDPOINT`, traces/metrics are exported to that
  endpoint; without an endpoint they are written to a local file. Review
  redaction and retention before enabling it.
- You are responsible for notices, consents, retention, deletion, and
  cross-border transfer obligations that apply to your deployment.

### 7. Acceptable use

Use Aruhan only within the laws and regulations of your jurisdiction. Your
conduct is your own responsibility and is unrelated to the publisher.

You must not use Aruhan to:

- violate any applicable law, regulation, sanctions, or export-control rule;
- infringe intellectual property, privacy, publicity, or database rights;
- distribute malware, ransomware, spyware, or destructive code;
- gain unauthorized access to systems, accounts, data, or networks;
- conduct denial-of-service, mass targeting, credential stuffing, or spam;
- evade security controls, detection, licensing, tenant isolation, or access
  controls;
- build or operate weapons, autonomous weapons, or systems intended to cause
  harm;
- make high-stakes decisions about individuals without qualified human review;
- process regulated data without a lawful basis and required safeguards;
- harass, threaten, discriminate, or generate unlawful content;
- misrepresent AI output as human professional advice.

This list is illustrative, not exhaustive.

### 8. High-risk and prohibited environments

Unless you have independently validated the system and obtained all required
 approvals, do not use Aruhan in:

- life-support, medical diagnosis, or clinical decision-making;
- aviation, rail, automotive safety, or industrial control safety loops;
- nuclear, chemical, biological, or weapons systems;
- emergency response, law enforcement, or judicial decision-making;
- critical infrastructure operations;
- financial trading or payment authorization without human controls.

AI output must not be the sole basis for decisions that can cause death, injury,
significant financial loss, or denial of essential services.

### 9. Reverse engineering, decompilation, and binary warnings

Project policy prohibits:

- decompiling, disassembling, or reverse engineering official binaries for the
  purpose of extracting credentials, license checks, tenant isolation logic, or
  other non-public security mechanisms;
- bypassing or defeating licensing, authentication, authorization, quotas,
  audit, or tenant boundaries;
- modifying official binaries to remove safety, security, or attribution
  notices;
- redistributing modified official binaries as if they were official builds;
- reselling, renting, leasing, sublicensing, or distributing the software to
  third parties without written permission from the copyright holder.

This policy is a distribution and support policy and does not grant any license
to source code. The distributed software is provided under the terms published
with each release. If you intend to reverse-engineer for interoperability,
security research, or other lawful purposes, obtain legal advice and comply
with applicable law and third-party terms.

Official binaries are currently **not code-signed on Windows**. Verify the
published `SHA256SUMS` before execution. Do not run binaries from untrusted
mirrors.

### 10. Security research and vulnerability reporting

- Do not test vulnerabilities on systems you do not own or have explicit
  permission to test.
- Do not access, modify, or exfiltrate other users' data.
- Report suspected vulnerabilities privately to the maintainers; include
  reproduction steps and affected versions, and allow reasonable remediation
  time before public disclosure.
- Good-faith research that respects these boundaries is welcome.

### 11. Third-party components and trademarks

- Aruhan includes third-party open-source components with their own licenses.
  See `licenses.json`, `sbom.cdx.json`, and the repositories of those projects.
- “Aruhan” and associated logos are project marks. Do not imply endorsement,
  sponsorship, or official status you do not have.
- All other product names, logos, and trademarks are the property of their
  respective owners. References are for identification only.

### 12. Export control and sanctions

You must comply with applicable export-control and sanctions laws. Do not use,
export, re-export, or transfer the software or technical data in violation of
those laws. You are responsible for determining whether your use requires a
license.

### 13. Indemnity

To the maximum extent permitted by law, you agree to indemnify and hold harmless
the authors, contributors, and copyright holders from claims, damages,
liabilities, costs, and expenses arising from your use of the software, your
configuration, your content, or your violation of this notice or applicable law.

### 14. Changes and severability

This notice may be updated with the project. The version published with a
release applies to that release. If any provision is held unenforceable, the
remaining provisions remain in effect.

### 15. Contact

Security reports, legal questions, commercial licensing, private/on-premises
deployment, custom development, and source-code or perpetual buyout:
**37735973@qq.com**. Do not include secrets, customer data, or exploit details
in public reports.

---

## 中文

### 1. 不提供担保

本软件及文档按“现状”和“可用”状态提供，不附带任何明示或暗示担保，包括但不限于
适销性、特定用途适用性、所有权、不侵权、准确性及安静享用担保。作者与版权持有人
不保证软件不中断、无错误、安全，或与任何特定系统/供应商兼容。

### 2. 责任限制

在适用法律允许的最大范围内，作者、贡献者与版权持有人不对任何直接、间接、附带、
特殊、示范性、后果性或惩罚性损害承担责任，也不对利润、收入、数据、商誉或商业机会
损失承担责任，无论是否已被告知此类损害的可能性。这包括 AI 输出、工具执行、模型
供应商、网络故障、配置错误或数据丢失造成的损害。

部分司法辖区不允许某些排除条款；此时按法律允许的最大范围适用。

### 3. AI 输出不是专业建议

Aruhan 会调用第三方或自托管语言/媒体模型。输出可能：

- 错误、不完整、过时、有偏见或令人不适；
- 不安全、不合规或侵权；
- 未经审查不适合生产；
- 因运行、模型、供应商和设置不同而变化。

你有责任在使用前审查、测试并验证所有输出。AI 输出**不构成**法律、医疗、金融、
税务、安全或其他专业建议。

### 4. 工具执行与智能体行为

Aruhan 可以读写文件、执行命令、控制终端、调用 MCP 工具、自动化浏览器，并在启用时
控制屏幕、键盘和鼠标。风险包括：

- 破坏性文件或数据库操作；
- 来自不可信文件、仓库、网页、邮件、Issue 或工具输出的命令注入与提示词注入；
- 凭据或数据外泄；
- 非预期的提交、推送、部署或购买；
- 生产环境中的不可逆操作。

你必须：

- 使用最小权限模式与沙箱范围；
- 批准前审查工具调用与差异；
- 不要在不可信内容或生产环境使用 `auto`/`yolo`/`bypassPermissions`；
- 保留备份与版本控制；
- 隔离不可信仓库（容器/虚拟机/独立用户）；
- 先非生产验证再上线。

### 5. 模型供应商、凭据与费用

- 你有责任合法获得你所配置的每个供应商的访问权，并遵守其条款、可接受使用政策、
  速率限制与数据处理条款。
- API Key 等凭据由你负责：安全存储、定期轮换，不得提交或分享。
- 供应商费用、配额与账单由你与供应商结算。Aruhan 不控制供应商定价、可用性或模型
  行为。
- 请求发往你配置的 Base URL。若指向第三方网关，该网关可能记录或保留你的数据。
- `aruhan.json` 的加密与机器绑定；复制到另一台机器不能带走可用 Key。

### 6. 隐私与数据处理

- Aruhan 本地优先：配置、会话、记忆和日志保存在你的机器（或你指定的数据目录）。
- 提示词、文件内容、工具输出和生成代码可能发送给你配置的模型供应商。未经授权或
  供应商条款不允许时，不要发送个人、机密、受监管或受出口管制的数据。
- 日志与诊断包可能包含提示词、路径、文件名和模型元数据。脱敏是尽力而为；分享前
  必须检查。
- 第三方供应商、MCP 服务器、插件、Hooks 和网关有自己的数据实践，使用前请审查。
- 可观测性遥测默认关闭。若部署设置 `ARUHAN_TELEMETRY_ENABLED=true` 并配置
  `ARUHAN_TELEMETRY_OTLP_ENDPOINT`，追踪/指标会导出到该端点；未配置端点时写入
  本地文件。启用前请审查脱敏与保留策略。
- 你需要负责适用于你部署的通知、同意、保留、删除和跨境传输义务。

### 7. 可接受使用

请在符合所在国家/地区相关法律法规的范围内使用 Aruhan。你的行为由你自行负责，
与发布者无关。

不得使用 Aruhan：

- 违反任何适用法律、法规、制裁或出口管制；
- 侵犯知识产权、隐私、肖像或数据库权利；
- 分发恶意软件、勒索软件、间谍软件或破坏性代码；
- 未经授权访问系统、账户、数据或网络；
- 实施拒绝服务、大规模攻击、撞库或垃圾信息；
- 规避安全控制、检测、授权、租户隔离或访问控制；
- 建造或操作武器、自主武器或意图造成伤害的系统；
- 在没有合格人工复核的情况下对个人做出高风险决策；
- 在没有合法依据和必要保障的情况下处理受监管数据；
- 骚扰、威胁、歧视或生成非法内容；
- 把 AI 输出冒充为人类专业建议。

以上列表为示例，并非穷尽。

### 8. 高风险与禁止环境

除非你已独立验证系统并取得所有必要批准，不要将 Aruhan 用于：

- 生命维持、医疗诊断或临床决策；
- 航空、铁路、汽车安全或工业控制安全回路；
- 核、化学、生物或武器系统；
- 应急响应、执法或司法决策；
- 关键基础设施运行；
- 没有人工控制金融交易或支付授权。

AI 输出不得作为可能造成死亡、伤害、重大财务损失或基本服务拒绝的唯一决策依据。

### 9. 逆向工程、反编译与二进制警告

项目政策禁止：

- 为提取凭据、授权校验、租户隔离逻辑或其他非公开安全机制，对官方二进制进行
  反编译、反汇编或逆向工程；
- 绕过或破坏授权、认证、授权、配额、审计或租户边界；
- 修改官方二进制以移除安全、安保或归属声明；
- 把修改过的官方二进制当作官方构建再分发；
- 未经版权持有人书面许可，转售、出租、出借、再许可或向第三方分发本软件。

本政策是分发与支持政策，不授予任何源代码许可。分发的软件适用各发布版本随附的
条款。若你打算为互操作、安全研究或其他合法目的进行逆向工程，请取得法律意见，
并遵守适用法律与第三方条款。

Windows 官方二进制目前**未做代码签名**。运行前请核对发布的 `SHA256SUMS`。不要运行
来自不可信镜像的二进制。

### 10. 安全研究与漏洞报告

- 不要测试你不拥有或没有明确授权的系统。
- 不要访问、修改或外泄其他用户的数据。
- 怀疑存在漏洞时，私下报告给维护者；提供复现步骤和受影响版本，并给予合理修复时间
  后再公开。
- 遵守上述边界的安全研究是受欢迎的。

### 11. 第三方组件与商标

- Aruhan 包含第三方开源组件，各自适用其许可证。见 `licenses.json`、`sbom.cdx.json`
  及相应项目仓库。
- “Aruhan”及相关标识是项目标识。不要暗示你并不拥有的背书、赞助或官方身份。
- 其他产品名称、标识和商标归各自所有者。引用仅用于识别。

### 12. 出口管制与制裁

你必须遵守适用的出口管制与制裁法律。不得违反这些法律使用、出口、再出口或转让本
软件或技术数据。你需要自行判断你的使用是否需要许可证。

### 13. 赔偿

在适用法律允许的最大范围内，你同意就因你的使用、配置、内容或违反本提示/适用法律
而产生的索赔、损害、责任、成本和费用，对作者、贡献者和版权持有人进行赔偿并使其
免受损害。

### 14. 变更与可分割性

本提示可能随项目更新。与某个发布一起发布的版本适用于该发布。若任何条款被认定
不可执行，其余条款继续有效。

### 15. 联系方式

安全报告、法律问题、商业授权、私有化/本地部署、定制开发以及源码或永久买断：
**37735973@qq.com**。不要在公开报告中包含密钥、客户数据或漏洞细节。
